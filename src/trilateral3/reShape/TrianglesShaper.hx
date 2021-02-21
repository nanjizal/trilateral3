package trilateral3.reShape;
import trilateral3.drawing.*;
import trilateral3.structure.XY;
import trilateral3.structure.XY0;
class TrianglesShaper {
    var pen:               Pen;
    var hi:                Float;
    var wid:               Float;
    public var curr:       TriangleAbstract;
    public var currUV:     TriangleAbstractUV;
    public var curr3color: Color3Abstract;
    var start:       Int;
    public function new( pen: Pen, wid: Float = 1000, hi: Float = 1000 ){
        this.pen        = pen;
        this.wid        = wid;
        this.hi         = hi;
        curr            = pen.triangleCurrent;
        if( pen.triangleCurrentUV != null ) currUV          = pen.triangleCurrentUV;
        curr3color      = pen.color3Current;
    }
    #if trilateral_hitDebug
        public function distHit( x: Float, y: Float ): Float {
            x = toGLx( x );
            y = toGLy( y );
            return curr.distHit( x, y );
        }
    #end
    public function fullHit( x: Float, y: Float ){
        x = toGLx( x );
        y = toGLy( y );
        return curr.fullHit( x, y );
    }
    public function liteHit( x: Float, y: Float ){
        x = toGLx( x );
        y = toGLy( y );
        return curr.liteHit( x, y );
    }
    public function hide(){
        argb = 0x00000000;
    }
    public function show(){
        argb = 0xFFFFFFFF;
    }
    public var alpha( never, set ): Float;
    inline
    function set_alpha( val: Float ){
        var int = Math.round( val * 255 );
        var val = ( int << 24) + 0x00FFFFFF;
        argb = val;
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
    // Not ideal but reverses matrix transforms 
    public function rotateCentre2( vx: Float, vy: Float, ax: Float, ay: Float, val: Float ){
        curr.rotate( toGLx( vx - ax ), toGLy( vy - ay ), val );
    }
    // Not ideal but reverses matrix transforms 
    public function rotateCentre( vx: Float, vy: Float, val: Float ){
        curr.rotate( toGLx( vx ), toGLy( vy ), val );
    }
    inline
    function toGLx( val: Float ){
        return (val-wid)/wid;
    }
    inline
    function toGLy( val: Float ){
        return -(val-wid)/wid;
    }
    inline
    function fromGLx( val: Float ){
        return val*wid+wid;
    }
    inline
    function fromGLy( val: Float ){
        return -(val*hi-hi);
    }
    public var xy0( get, set ): XY0;
    inline
    function get_xy0(): XY0 {
        return { x: Math.round( xy.x ), y: Math.round( xy.y ) };
    }
    inline
    function set_xy0( val: XY0 ): XY0 {
        x = val.x;
        y = val.y;
        return val;
    }
    public var xy1( get, set ): XY;
    inline
    function get_xy1(): XY{
        return { x: Math.round( xy.x*10 )/10, y: Math.round( xy.y*10 )/10 };
    }
    inline
    function set_xy1( val: XY ): XY {
        return set_xy( val );
    }
    public var xy2( get, set ): XY;
    inline
    function get_xy2(): XY{
        return { x: Math.round( xy.x*100 )/100, y: Math.round( xy.y*100 )/100 };
    }
    inline
    function set_xy2( val: XY ): XY {
        return set_xy( val );
    }
    public var xy( get, set ): XY;
    inline
    function get_xy(): XY {
        return { x: x, y: y };
    }
    inline
    function set_xy( xy: XY ): XY {
        x = xy.x;
        y = xy.y;
        return xy;
    } 
    public var x( get, set ): Float;
    inline
    function get_x(): Float {
        return fromGLx( curr.x );
    }
    inline
    function set_x( val: Float ): Float {
        var val_ = toGLx( val);
        curr.x = val_;
        return val;
    }
    public var y( get, set ): Float;
    inline
    function get_y(): Float {
        return fromGLy( curr.y );
    }
    inline
    function set_y( val: Float ): Float {
        var val_ = toGLy( val );
        curr.y = val_;
        return val;
    }
    public var z( get, set ): Float;
    inline
    function get_z(): Float {
        return curr.z;
    }
    inline
    function set_z( val: Float ): Float {
        curr.z = val;
        return val;
    }
    public var right( get, never ): Float;
    inline
    function get_right(): Float {
        return fromGLx( curr.right );
    }
    public var bottom( get, never ): Float;
    inline
    function get_bottom(): Float {
        return fromGLy( curr.bottom );
    }
    public var uv( get, set ): XY;
    inline
    function get_uv(): XY {
        return { x: x, y: y };
    }
    inline
    function set_uv( xy: XY ): XY {
        u = xy.x;
        v = xy.y;
        return xy;
    } 
    public var u( get, set ): Float;
    inline
    function get_u(): Float {
        return -currUV.u*1000;
    }
    inline
    function set_u( val: Float ){
        var val_ = ( -val )/1000;
        currUV.u = val_;
        return val;
    }
    public var v( get, set ): Float;
    inline
    function get_v(): Float {
        return -currUV.v*1000;
    }
    inline
    function set_v( val: Float ){
        var val_ = ( -val )/1000;
        currUV.v = val_;
        return val;
    }
    
}