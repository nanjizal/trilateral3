package trilateral3.reShape;
import trilateral3.drawing.Pen;
import trilateral3.reShape.QuadShaper;
import trilateral3.shape.IteratorRange;
import trilateral3.color.ColorInt;
class NineSlice {
    public var posMin:    Int;
    public var pen:       Pen;
    public var x:         Float;
    public var y:         Float;
    public var wid:       Float;
    public var hi:        Float;
    public var left:      Float;
    public var top:       Float;
    public var fat:       Float;
    public var tall:      Float;
    public var quadRange: IteratorRange;
    public var arrShaper: Array<QuadShaper>;
    // A B C
    // D E F
    // G H I
    public
    function new( pen_: Pen ){
        pen = pen_;
    }
    public 
    function addSlices( x:          Float,      y:        Float
                      , wid:        Float,      hi:       Float
                      , left:       Float,      top:      Float
                      , fat:        Float,      tall:     Float
                      , color:      Int ){
         posMin = Std.int( pen.pos );
         this.x    = x;
         this.y    = y;
         this.wid  = wid;
         this.hi   = hi;
         this.left = left;
         this.top  = top;
         this.fat  = fat;
         this.tall = tall;
         var ds = posMin;
         var count = 0;
         arrShaper = new Array<QuadShaper>();
         for( iy in 0...3 ){
             for( ix in 0...3 ){
                 // creates four color gradient square
                 var quadShaper       = new QuadShaper( pen, ds );
                 arrShaper[ arrShaper.length ] = quadShaper;
                 ds+=2;
             }
          }
          pen.pos = posMin;
          update();
    }
    public var rightW( get, never ): Float;
    inline function get_rightW() {
        return wid - left - fat;
    }
    public var bottomH( get, never ): Float;
    inline function get_bottomH(): Float {
        return hi - top - tall;
    }
    public var leftX( get, never ): Float;
    inline function get_leftX(): Float {
        return x + left;
    }
    public var topY( get, never ): Float;
    inline function get_topY(): Float {
        return y + top;
    }
    public var rightX( get, never ): Float;
    inline function get_rightX() {
        return x + left + fat;
    }
    public var bottomY( get, never ): Float;
    inline function get_bottomY(): Float {
        return y + top + tall;
    }
    public function update(){
        pen.pos = posMin;
        // first row
        // A 
        //var ds = posMin;
        var quadShaper = arrShaper[0].drawQuadStart( x, y, left, top );
        // B
        //ds += 2;
        quadShaper = arrShaper[1].drawQuadStart( leftX, y, fat, top );
        // C
        //ds += 2;
        arrShaper[2].drawQuadStart( rightX, y, rightW, top);
        // second row
        // D
        arrShaper[3].drawQuadStart( x, topY, left, tall );
        // E -- Middle
        quadShaper = arrShaper[4].drawQuadStart( leftX, topY, fat, tall );
        // F
        arrShaper[5].drawQuadStart( rightX, topY, rightW, tall );
        // third row
        // G
        //ds += 2;
        arrShaper[6].drawQuadStart( x, bottomY, left, bottomH );
        // H 
        arrShaper[7].drawQuadStart( leftX, bottomY, fat, bottomH );
        // I
        arrShaper[8].drawQuadStart( rightX, bottomY, rightW, bottomH );
        pen.pos = posMin;
    }
    public
    function modifyColors( color0:  Int, color1:  Int, color2:  Int, color3: Int
                         , color4:  Int, color5:  Int, color6:  Int, color7: Int
                         , color8:  Int, color9:  Int, color10: Int, color11: Int
                         , color12: Int, color13: Int, color14: Int, color15: Int ){
         //  0  1  2  3
         //  4  5  6  7
         //  8  9 10 11
         // 12 13 14 15
         // first row
         // A 
         var quadShaper = arrShaper[0];
         quadShaper.modifyQuadColors( color0, color1, color5, color4 );
         // B
         quadShaper = arrShaper[1];
         quadShaper.modifyQuadColors( color1, color2, color6, color5 );
         // C
         quadShaper = arrShaper[2];
         quadShaper.modifyQuadColors( color2, color3, color7, color6 );
         // second row
         // D
         quadShaper = arrShaper[3];
         quadShaper.modifyQuadColors( color4, color5, color9, color8 );
         // E -- Middle
         quadShaper = arrShaper[4];
         quadShaper.modifyQuadColors( color5, color6, color10, color9 );
         // F
         quadShaper = arrShaper[5];
         quadShaper.modifyQuadColors( color6, color7, color11, color10 );
         // third row
         // G
         quadShaper = arrShaper[6];
         quadShaper.modifyQuadColors( color8, color9, color13, color12 );
         // H 
         quadShaper = arrShaper[7];
         quadShaper.modifyQuadColors( color9, color10, color14, color13 );
         // I
         quadShaper = arrShaper[8];
         quadShaper.modifyQuadColors( color10, color11, color15, color14 );
    }
    public
    function getBorder():{ bLeft: Float, bRight: Float
                         , bTop: Float, bBottom: Float }{
        return { bLeft: left, bRight: rightW, bTop: top, bBottom: bottomH }; 
    }
    public
    function scaleBorder( s: Float, keepDim: Bool ){
        var b = getBorder();
        adjustBorder( b.bLeft*s, b.bRight*s, b.bTop*s, b.bBottom*s, keepDim );
    }
    public
    function setBorder( b: { bLeft: Float, bRight: Float, bTop: Float, bBottom: Float }, keepDim ){
        adjustBorder( b.bLeft, b.bRight, b.bTop, b.bBottom, keepDim );
    }
    public
    function adjustBorder( bLeft: Float, bRight: Float
                         , bTop: Float, bBottom: Float, keepDim: Bool ){
        var p = pen.pos;
        var quadShaper: QuadShaper;
        var dLeft   = left    - bLeft;
        var dRight  = rightW  - bRight;
        var dTop    = top     - bTop;
        var dBottom = bottomH - bBottom;
        var oldWid  = wid;
        var oldHi   = hi;
        wid         = wid     - dLeft - dRight;
        hi          = hi      - dTop  - dBottom;
        left        = bLeft;
        top         = bTop;
        // A
        quadShaper = arrShaper[0];
        quadShaper.dim( bLeft, bTop );
        // B 
        quadShaper = arrShaper[1];
        quadShaper.x -= dLeft;
        // C
        quadShaper = arrShaper[ 2 ];
        quadShaper.dim( bRight, bTop );
        quadShaper.x -= bRight;
        // D
        quadShaper = arrShaper[ 3 ];
        quadShaper.y -= dTop;
        // E -- Middle
        quadShaper = arrShaper[ 4 ];
        quadShaper.x -= dLeft;
        quadShaper.y -= dTop;
        // F
        quadShaper = arrShaper[ 5 ];
        quadShaper.x -= dLeft;
        quadShaper.y -= dTop;
        // G
        quadShaper = arrShaper[ 6 ];
        quadShaper.dim( bLeft, bBottom );
        // H 
        quadShaper = arrShaper[7];
        quadShaper.x -= dLeft;
        quadShaper.y -= dTop;
        // I
        quadShaper = arrShaper[8];
        quadShaper.dim( bRight, bBottom );
        pen.pos = p;
        if( keepDim ) {
            dim( oldWid, oldHi );
        } else {
            dim( wid, hi );
        }
    }
    public
    function dim( w: Float, h: Float ){
        var p = pen.pos;
        //pen.pos = posMin;
        var rW = rightW;
        var bH = bottomH;
        var borderW = left + rW;
        var borderH = top + bH;
        if( w < borderW || h < borderH ) 
            throw new haxe.Exception( 'dimensions need to be larger');
        fat  = w - borderW;
        tall = h - borderH;
        wid = w;
        hi = h;
        //   note  '///' lines needed in scale implementations..
        var quadShaper: QuadShaper;
        // A
        quadShaper = arrShaper[0];
        quadShaper.dim( left, top );///
        // don't adjust
        // B
        quadShaper = arrShaper[ 1 ];
        quadShaper.dim( fat, top );
        // C
        quadShaper = arrShaper[ 2 ];
        quadShaper.dim( rightW, top ); //
        quadShaper.x = rightX;
        // second row
        // D
        quadShaper = arrShaper[ 3 ];
        quadShaper.dim( left, tall );
        // E -- Middle
        quadShaper = arrShaper[ 4 ];
        quadShaper.dim( fat, tall );
        // F
        quadShaper = arrShaper[ 5 ];
        quadShaper.dim( rightW, tall );
        quadShaper.x = rightX;
        // third row
        // G
        quadShaper = arrShaper[ 6 ];
        quadShaper.dim( left, bottomH ); // 
        quadShaper.y = bottomY;
        // H 
        quadShaper = arrShaper[7];
        quadShaper.dim( fat, bottomH );
        quadShaper.y = bottomY;
        // I
        quadShaper = arrShaper[8];
        quadShaper.dim( rightW, bottomH ); // 
        quadShaper.x = rightX;
        quadShaper.y = bottomY;
        pen.pos = p;
    }
    public 
    function addEqualGrid( x:     Float,       y: Float
                         , wid:    Float,      hi: Float
                         , color:  Int ){
        posMin = Std.int( pen.pos );
        this.x = x;
        this.y = y;
        this.wid = wid;
        this.hi = hi;
        var sx = x;
        var sy = y;
        var px = sx;
        var py = sy;
        var dx = wid / ( 3 - 1 );
        var dy = hi / ( 3 - 1 );
        var ds = posMin;
        arrShaper = new Array<QuadShaper>();
        for( iy in 0...3 ){
            for( ix in 0...3 ){
                // creates four color gradient square
                var quadShaper       = new QuadShaper( pen, ds );
                arrShaper[ arrShaper.length ] = quadShaper;
                ds+=2;
                quadShaper.drawQuad( px, py, dx, dy );
                px += dx;
            }
            px = sx;
            py += dy;
        }
    }

}