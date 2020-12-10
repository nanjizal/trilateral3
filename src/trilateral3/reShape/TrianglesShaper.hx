package trilateral3.reShape;
import trilateral3.drawing.*;
class TrianglesShaper {
    var pen:         Pen;
    public var curr:        TriangleAbstract;
    public var currUV:      TriangleAbstractUV;
    public var curr3color:  Color3Abstract;
    var start:       Int;
    public function new( pen: Pen ){
        this.pen        = pen;
        curr            = pen.triangleCurrent;
        currUV          = pen.triangleCurrentUV;
        curr3color      = pen.color3Current;
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
    // Not ideal but reverses matrix transforms 
    public function rotateCentre2( vx: Float, vy: Float, ax: Float, ay: Float, val: Float ){
        curr.rotate( (vx-ax)/1000, -(vy-ay)/1000, val );
    }
    // Not ideal but reverses matrix transforms 
    public function rotateCentre( vx: Float, vy: Float, val: Float ){
        curr.rotate( (vx-1000)/1000, -(vy-1000)/1000, val );
    }
    public var x( get, set ): Float;
    public function get_x(): Float {
        return curr.x*1000+1000;
    }
    public function set_x( val: Float ): Float {
        var val_ = (val-1000)/1000;
        curr.x = val_;
        return val;
    }
    public var y( get, set ): Float;
    public function get_y(): Float {
        return -(curr.y*1000-1000);
    }
    public function set_y( val: Float ): Float {
        var val_ = -(val-1000)/1000;
        curr.y = val_;
        return val;
    }
    public var z( get, set ): Float;
    public function get_z(): Float {
        return curr.z;
    }
    public function set_z( val: Float ): Float {
        curr.z = val;
        return val;
    }
    public var right( get, never ): Float;
    public function get_right(): Float {
        return (curr.right*1000-1000);
    }
    public var bottom( get, never ): Float;
    public function get_bottom(): Float {
        return -(curr.bottom*1000-1000);
    }
    public var u( get, set ): Float;
    public function get_u(): Float {
        return -currUV.u*1000;
    }
    public function set_u( val: Float ){
        var val_ = ( -val )/1000;
        currUV.u = val_;
        return val;
    }
    public var v( get, set ): Float;
    public function get_v(): Float {
        return -currUV.v*1000;
    }
    public function set_v( val: Float ){
        var val_ = ( -val )/1000;
        currUV.v = val_;
        return val;
    }
    
}