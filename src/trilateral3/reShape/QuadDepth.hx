package trilateral3.reShape;
import trilateral3.drawing.Pen;
import trilateral3.shape.IteratorRange;
import trilateral3.reShape.QuadShaper;
import trilateral3.reShape.DepthArray;
import trilateral3.structure.XY;
class QuadDepth {
    public var pen:      Pen; 
    public var space:  Float = 0;
    public var orderCount = new DepthArray( new Array<Int>() );
    public var depthPieces = new DepthArray( new Array<QuadShaper>() );
    public var origPos = new Array<XY>();
    public var range:    IteratorRange;
    public var quadRange:IteratorRange;
    public var topLast:  Int;
    public var last:     Int;
    public
    function new( pen_: Pen ){
        pen = pen_;
    }
    public
    function traceBegins( w: Int ){
        var str: String = '';
        for( i in 0...depthPieces.length ){
            str += ( depthPieces[ i ].begin ) + ', ';
            if( ( i + 1 ) % w == 0 ) {
                str.substr( 0, depthPieces.length - 2 );
                trace( str );
                str = '';
            }
        }
        str.substr( 0, depthPieces.length - 2 );
        trace( str );
    }
    public
    function traceOrderCount( w: Int ){
        var str: String = '';
        for( i in 0...orderCount.length ){
            str += ( orderCount[ i ] ) + ', ';
            if( (i+1) % w == 0 ) {
                str.substr( 0, orderCount.length - 2 );
                trace( str );
                str = '';
            }
        }
        str.substr( 0, orderCount.length - 2 );
        trace( str );
    }
    inline
    function addQuad( dx: Float, dy: Float
                    , w:  Float, h:  Float
                    , u:  Float, v:  Float
                    , col: Int, row: Int
                    , count: Int ){
        var curPos = pen.pos;
        pen.quad2DFill( u, v, w, h );
        var quad    = new QuadShaper( pen, Std.int( curPos ) );
        // store current grid position.
        var pos: XY = { x: u + dx + space*col, y: v + dy + space*row };
        quad.xy = pos;
        origPos[ origPos.length ] = pos.clone();
        depthPieces[ depthPieces.length ] = quad;
        orderCount[ orderCount.length ]   = count;
        quad.name = Std.string( col ) + 'x' + Std.string( row );
        quad.updatePos(); // make sure pen is after drawn quad.
    }
    // onlyCreate used if you don't need the full grid of images.
    public
    function grid( x:  Float, y:  Float
                 , dw: Float, dh: Float
                 , nW: Int,   nH: Int, ?onlyCreate: Array<Int> ){
        var u = 0.;
        var v = 0.;
        var count  = 0;
        var curPos = pen.pos; 
        var quad:  QuadShaper;
        topLast = 2*nH*nW-2;
        var startRange = cast pen.pos;
        for( row in 0...nH ){
            for( col in 0...nW ){
                if( onlyCreate != null ){
                    if( onlyCreate.contains( count ) ){
                        addQuad( x, y, dw, dh, u, v, col, row, count ); // assuming image is at 0, 0
                    }
                } else {
                    addQuad( x, y, dw, dh, u, v, col, row, count ); // assuming image is at 0, 0
                }
                u += dw;  //  - 10; take away for debug.
                count++;
            }
            u = 0;
            v += dh;  // - 10; take away for debug.
        }
        var curPos: Int = cast pen.pos;
        count--;
        range     = startRange...curPos;
        pen.pos   = 0;
        last      = curPos;
        quadRange = 0...depthPieces.length;
    }
    
    // changing properties
    public function deltaXY( id: Int, dx: Float, dy: Float ){
        var quad =  getQuad( id );
        var xy =    quad.xy;
        xy.y +=     dx;
        xy.x +=     dy;
        quad.xy = xy    ;
    }
    public function setXY( id: Int, x: Float, y: Float ){
        getQuad( id ).xy = { x: x, y: y };
    }
    public function getXY( id: Int ){
        return getQuad( id ).xy;
    }
    public function argbQuad( id: Int, argb: Int ){
        getQuad( id ).argb = argb;
    }
    public function alphaQuad( id: Int, alpha: Float ){
        getQuad( id ).alpha = alpha;
    }
    public function hideQuad( id: Int ){
        getQuad( id ).visible = false;
    }
    public function showQuad( id: Int ){
        getQuad( id ).visible = true;
    }
    public
    function fullHit( x: Float, y: Float ): Array<Int> {
        var hitArray = new Array<Int>();
        var j: Int;
        var l = orderCount.length;
        var l1 = l - 1;
        for( i in 0...l ){
            // reverse so higher one found first.
            j = l1 - i;
            if( depthPieces[ j ].fullHit( x, y ) ) {
                hitArray[ hitArray.length ] = orderCount[ j ];
            }
        }
        return hitArray;
    }
    public
    function getQuad( countNo: Int ): QuadShaper {
        return depthPieces[ depthIndex( countNo ) ];
    }
    public inline
    function depthIndex( countNo: Int ): Int {
        return orderCount.indexOf( countNo );
    }
    public
    function toTopCount( countNo: Int ){
        var pieceNo = depthIndex( countNo );
        toTop( pieceNo );
    }
    public
    function getLast(): Int {
        return orderCount[ orderCount.length - 1 ];
    }
    public
    function getPenultimate(): Int {
        return orderCount[ orderCount.length - 2 ];
    }
    // unchecked
    public
    function swap( pieceNo0: Int, pieceNo1: Int ){
        var startpos0 = depthPieces[ pieceNo0 ].begin;
        var startpos1 = depthPieces[ pieceNo1 ].begin;
        swapInternal( startpos0, startpos1, 2 );
        depthPieces.rangeSwap( pieceNo0 + 1, pieceNo1 + 1, 1 );
        orderCount.rangeSwap(  pieceNo0 + 1, pieceNo1 + 1, 1 );
        // unsure starts need to be changed.
    } 
    public
    function toTop( pieceNo: Int ){//, lastPos: Int ){
        //var lastPos = topLast;
        var startpos = depthPieces[ pieceNo ].begin;
        var updatePieces = setEnd( startpos, 2 );
        depthPieces.rangeToEnd( pieceNo + 1, 1 );
        orderCount.rangeToEnd(  pieceNo + 1, 1 );
        updateStarts();
    }
    public
    function justLocalTop( countNo: Int ){
        var pieceNo = depthIndex( countNo );
        depthPieces.rangeToEnd( pieceNo + 1, 1 );
        orderCount.rangeToEnd(  pieceNo + 1, 1 );
        updateStarts();
    }
    public
    function toBottomCount( countNo: Int ){
        var pieceNo = depthIndex( countNo );
        toBottom( pieceNo );
    }
    public
    function toBottom( pieceNo: Int ){//, startPos: Int ){
        var indexpos = depthPieces[ pieceNo ].begin;
        var updatePieces = setStart( indexpos, 2 );
        // untested
        depthPieces.rangeToStart( pieceNo + 1, 1 );
        orderCount.rangeToStart(  pieceNo + 1, 1 );
        updateStarts();
    }
    inline
    function setStart( v: Int, len: Int ): IteratorRange {
        return ( pen.setStartDepth( v, len ) )? len...( v ): 0...0;
    }
    inline
    function setEnd( v: Int, len: Int ): IteratorRange {
        return ( pen.setEndDepth( v, len ) )? ( v+1 )...( pen.size - len + 1 ): ( 0...0 );
    }
    inline
    function swapInternal( v0: Int, v1: Int, len: Int ): Bool {
        return pen.swapDepth( v0, v1, len );
    }
    // not ideal updates starts of all pieces not just the effected.
    function updateStarts(){
        var starts = range.start;
        var quad: QuadShaper;
        var len = depthPieces.length;
        for( i in 0...len ) {
            quad = depthPieces[ i ];
            quad.begin = Std.int( starts + i*2 );
        }
    }
    /*
    // Hittest code
    #if trilateral_hitDebug
    public
    function distHit( x: Float, y: Float ) {
        var count   = 0;
        var minDist = 1000000000000000;
        var nearest = 0;
        var dist    = 1000000000000000;
        var l = orderCount.length;
        for( i in 0...l ){
            dist = depthPiece[ i ].distHit( x, y );
            if( dist < minDist ) {
                nearest = orderCount[ i ];
                minDist = dist;
            }
        }
        return { nearest: nearest, dist: dist };
    }
    #end
    */
}