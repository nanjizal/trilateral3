package trilateral3.reShape;
import trilateral3.drawing.Pen;
import trilateral3.shape.IteratorRange;
import trilateral3.reShape.RangeShaper;
import trilateral3.reShape.DepthArray;
import trilateral3.structure.XY;
class RangeDepth {
    public var pen:      Pen; 
    public var orderCount = new DepthArray( new Array<Int>() );
    public var depthPieces = new DepthArray( new Array<RangeShaper>() );
    public var rangeLen: Int;
    public var count: Int = 0;  
    public var startRange: Int;
    public var range:    IteratorRange;
    public
    function new( pen_: Pen, rangeLen_: Int ){
        pen = pen_;
        rangeLen = rangeLen_;
        var curPos: Int = cast pen.pos;
        startRange = curPos;
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
    public
    function addShape( rangeShaper: RangeShaper ){
        //origPos[ origPos.length ] = pos.clone();
        depthPieces[ depthPieces.length ] = rangeShaper;
        orderCount[ orderCount.length ]   = count;
        count++;
        var curPos: Int = cast pen.pos;
        range     = startRange...curPos;
    }
    public
    function getShape( countNo: Int ): RangeShaper {
        return depthPieces[ depthIndex( countNo ) ];
    }
    public inline
    function depthIndex( countNo: Int ): Int {
        return orderCount.indexOf( countNo );
    }
    // changing properties
    public function deltaXY( id: Int, dx: Float, dy: Float ){
        var rangeShaper =  getShape( id );
        var xy =    rangeShaper.xy;
        xy.y +=     dx;
        xy.x +=     dy;
        rangeShaper.xy = xy;
    }
    public function setXY( id: Int, x: Float, y: Float ){
        getShape( id ).xy = { x: x, y: y };
    }
    public function getXY( id: Int ){
        return getShape( id ).xy;
    }
    public function argbShape( id: Int, argb: Int ){
        getShape( id ).argb = argb;
    }
    public function alphaShape( id: Int, alpha: Float ){
        getShape( id ).alpha = alpha;
    }
    public function hideShape( id: Int ){
        getShape( id ).visible = false;
    }
    public function showShape( id: Int ){
        getShape( id ).visible = true;
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
            if( depthPieces[ j ].wasHit( x, y ) ) {
                hitArray[ hitArray.length ] = orderCount[ j ];
            }
        }
        return hitArray;
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
    public
    function swap( pieceNo0: Int, pieceNo1: Int ){
        var startpos0 = depthPieces[ pieceNo0 ].begin;
        var startpos1 = depthPieces[ pieceNo1 ].begin;
        swapInternal( startpos0, startpos1, rangeLen );
        depthPieces.rangeSwap( pieceNo0 + 1, pieceNo1 + 1, 1 );
        orderCount.rangeSwap(  pieceNo0 + 1, pieceNo1 + 1, 1 );
        // unsure starts need to be changed.
    } 
    public
    function toTop( pieceNo: Int ){//, lastPos: Int ){
        //var lastPos = topLast;
        var startpos = depthPieces[ pieceNo ].begin;
        var updatePieces = setEnd( startpos, rangeLen );
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
        var updatePieces = setStart( indexpos, rangeLen );
        // untested
        depthPieces.rangeToStart( pieceNo + 1, 1 );
        orderCount.rangeToStart(  pieceNo + 1, 1 );
        updateStarts();
    }
    // not ideal updates starts of all pieces not just the effected.
    function updateStarts(){
        var starts = range.start;
        var rangeShaper: RangeShaper;
        var len = depthPieces.length;
        for( i in 0...len ) {
            rangeShaper = depthPieces[ i ];
            rangeShaper.begin = Std.int( starts + i*rangeLen );
        }
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
}