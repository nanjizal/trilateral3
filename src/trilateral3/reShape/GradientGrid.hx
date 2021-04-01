package trilateral3.reShape;
import trilateral3.drawing.Pen;
import trilateral3.reShape.QuadShaper;
import trilateral3.shape.IteratorRange;
import trilateral3.color.ColorInt;
class GradientGrid {
    public var posMin:    Int;
    public var pen:       Pen;
    public var x:         Float;
    public var y:         Float;
    public var wid:       Float;
    public var hi:        Float;
    public var col:       Int;
    public var row:       Int;
    public var quadRange: IteratorRange;
    public var arrShaper: Array<QuadShaper>;
    public
    function new( pen_: Pen ){
        pen = pen_;
    }
    public static inline
    function radAdj( r: Float ){
        return r*Math.PI/50;
    }
    public static inline
    function sin01( r: Float ){
        return 0.5+(Math.sin( r )/2);
    }
    public static inline
    function cos01( r: Float ){
        return 0.5+(Math.cos( r )/2);
    }
    public
    function addGrid( x:     Float,       y: Float
                    , wid:    Float,      hi: Float
                    , col:    Int,        row: Int
                    , dX:     Float,      dY:     Float
                    , fRed:   ( x: Float, y: Float ) -> Float
                    , fGreen: ( x: Float, y: Float ) -> Float
                    , fBlue:  ( x: Float, y: Float ) -> Float ){
            posMin = Std.int( pen.pos );
            //trace('pen ' + pen );
            // create a grid of quad and populate it with an image
            this.x = x;
            this.y = y;
            this.wid = wid;
            this.hi = hi;
            this.col = col;
            this.row = row;
            var sx = x;
            var sy = y;
            var px = sx;
            var py = sy;
            var dx = wid / ( col - 1 );
            var dy = hi / ( row - 1 );
            var ds = 0;
            var iy = 0;
            var ix = 0;
            arrShaper = new Array<QuadShaper>();
            var count = 0;
            var ix1: Int;
            var iy1: Int;
            for( iy in 0...row ){
                for( ix in 0...col ){
                    // creates four color gradient square
                    var quadShaper       = new QuadShaper( pen, ds );
                    arrShaper[ arrShaper.length ] = quadShaper;
                    ds+=2;
                    ix1 = ix + 1;
                    iy1 = iy + 1;
                    var colorA = genColors( ix  * dX, iy  * dY, fRed, fGreen, fBlue );
                    var colorB = genColors( ix1 * dX, iy  * dY, fRed, fGreen, fBlue );
                    var colorC = genColors( ix1 * dX, iy1 * dY, fRed, fGreen, fBlue );
                    var colorD = genColors( ix  * dX, iy1 * dY, fRed, fGreen, fBlue );
                    quadShaper.drawQuadColors( px, py, dx, dy
                                             , colorA, colorB, colorC, colorD );
                    px += dx;
                }
                px = sx;
                py += dy;
            }
            quadRange = posMin...Std.int( pen.pos );
            return quadRange;
    }
    public static inline
    function genColors( x: Float, y: Float
                      , fRed:   ( x: Float, y: Float ) -> Float
                      , fGreen: ( x: Float, y: Float )-> Float
                      , fBlue:  ( x: Float, y: Float )-> Float ): ColorInt {
        var col: ColorInt = 0xFF000000;
        col.red   = fRed( x, y );
        col.green = fGreen( x, y );
        col.blue  = fBlue( x, y );
        return col;
    }
    public
    function modifyColor(   dX:     Float,      dY:     Float
                          , fRed:   ( x: Float , y: Float ) -> Float
                          , fGreen: ( x: Float, y: Float )-> Float
                          , fBlue:  ( x: Float, y: Float )-> Float ){
        var count = 0;
        for( iy in 0...this.row ){
            for( ix in 0...this.col ){
                var quadShape: QuadShaper = arrShaper[ count ];
                count++;
                var colorA = genColors( ix * dX, iy * dY, fRed, fGreen, fBlue );
                var colorB = genColors( (ix + 1 )* dX, iy * dY, fRed, fGreen, fBlue );
                var colorC = genColors( ( ix + 1 ) * dX, ( iy + 1 ) * dY, fRed, fGreen, fBlue );
                var colorD = genColors( ix * dX, ( iy + 1 ) * dY, fRed, fGreen, fBlue );
                quadShape.modifyQuadColors( colorA, colorB, colorC, colorD );
            }
        }
    }
}