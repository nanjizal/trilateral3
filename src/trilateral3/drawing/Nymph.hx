package trilateral3.drawing;
import trilateral3.drawing.Pen;
import trilateral3.drawing.TriangleAbstract;
import trilateral3.drawing.TriangleAbstractUV;
import trilateral3.drawing.Color3Abstract;
import trilateral3.shape.IndexRange;

class Nymph {
    var pen:         Pen;
    var curr:        TriangleAbstract;
    var currUV:      TriangleAbstractUV;
    var curr3color:  Color3Abstract;
    var indexRange:  IndexRange;
    var sx: Array<Float> = [];
    var sy: Array<Float> = [];
    var su: Array<Float> = [];
    var sv: Array<Float> = [];
    var theta = 0.;
    public function new( pen: Pen, indexRange: IndexRange ){
        this.pen        = pen;
        curr            = pen.triangleCurrent;
        currUV          = pen.triangleCurrentUV;
        curr3color      = pen.color3Current;
        this.indexRange = indexRange;
        for( i in (indexRange.start)...(indexRange.end+1) ){
            pen.pos  = i;
            sx.push( x );
            sy.push( y );
            su.push( u );
            sv.push( v );
        }
    }
    public function moveStart( sx_: Float, sy_: Float, su_: Float, sv_: Float ){
        var count = 0;
        for( i in indexRange.start...indexRange.end ){
            pen.pos  = i;
            sx[ count ] = sx[ count ] + sx_;
            sy[ count ] = sy[ count ] + sy_;
            su[ count ] = su[ count ] + su_;
            sv[ count ] = sv[ count ] + sv_;
            x = sx[ count ];
            y = sy[ count ];
            u = su[ count ];
            v = sv[ count ];
            
            count++;
        }
    }
    public function dMoveXY( dx: Float, dy: Float ){
        var count = 0;
        for( i in indexRange.start...indexRange.end ){
            pen.pos  = i;
            x = sx[ count ] + dx;
            y = sy[ count ] + dy;
            count++;
        }
    }
    public function dMoveUV( du: Float, dv: Float ){
        var count = 0;
        for( i in indexRange.start...indexRange.end ){
            pen.pos  = i;
            u = su[ count ] + du;
            v = sv[ count ] + dv;
            count++;
        }
    }
    public function dMoveXYUV( dx: Float, dy: Float, du: Float, dv: Float ){
        var count = 0;
        for( i in indexRange.start...(indexRange.end) ){
            pen.pos  = i;
            x = sx[ count ] + dx;
            y = sy[ count ] + dy;
            u = su[ count ] + du;
            v = sv[ count ] + dv;
            count++;
        }
    }
    public function setColor( col: Int ){
        for( i in indexRange.start...indexRange.end ){
            pen.pos  = i;
            argb = col;
        }
    }
    public function setRndColor( col: Int ){
        for( i in indexRange.start...indexRange.end ){
            pen.pos  = i;
            argb = Std.int(Math.random()*0xFFFFFF + 0xff000000 );//col;
        }
    }
    public function dRotate( dx: Float, dy: Float, dr: Float ){
        for( i in indexRange.start...indexRange.end ){
            pen.pos = i;
            rotateCentre( dx, dy, dr );
        }
        theta += dr;
    }
    // Not ideal but reverses matrix transforms 
    public function rotateCentre2( vx: Float, vy: Float, ax: Float, ay: Float, val: Float ){
        curr.rotate( (vx-ax)/1000, -(vy-ay)/1000, val );
    }
    // Not ideal but reverses matrix transforms 
    public function rotateCentre( vx: Float, vy: Float, val: Float ){
        curr.rotate( (vx-1000)/1000, -(vy-1000)/1000, val );
    }
    var x( get, set ): Float;
    public function get_x(): Float {
        return curr.x*1000+1000;
    }
    public function set_x( val: Float ): Float {
        var val_ = (val-1000)/1000;
        curr.x = val_;
        return val;
    }
    var y( get, set ): Float;
    public function get_y(): Float {
        return -(curr.y*1000-1000);
    }
    public function set_y( val: Float ): Float {
        var val_ = -(val-1000)/1000;
        curr.y = val_;
        return val;
    }
    var u( get, set ): Float;
    public function get_u(): Float {
        return -currUV.u*1000;
    }
    public function set_u( val: Float ){
        var val_ = ( -val )/1000;
        currUV.u = val_;
        return val;
    }
    var v( get, set ): Float;
    public function get_v(): Float {
        return -currUV.v*1000;
    }
    public function set_v( val: Float ){
        var val_ = ( -val )/1000;
        currUV.v = val_;
        return val;
    }
    public var argb( get, set ): Int;
    var _argb = 0xFFFFFFFF;
    inline
    function set_argb( col: Int ): Int {
        curr3color.argb = col;
        _argb = col;
        return col;
    }
    inline
    function get_argb():Int {
        return _argb;
    }
}