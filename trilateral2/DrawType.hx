package trilateral2; 
import geom.matrix.Matrix4x3;
typedef DrawType = {
    var triangle: ( ax_: Float, ay_: Float, az_: Float
          , bx_: Float, by_: Float, bz_: Float
          , cx_: Float, cy_: Float, cz_: Float ) -> Bool;
    var transform: ( Matrix4x3 ) -> Void;
    var transformRange: ( m: Matrix4x3, start: Int, end: Int ) -> Void;
    var next: ()->Float;
    var hasNext: ()->Bool;
    public function get_pos(): Float;
    public function set_pos( v: Float ): Float;
    public function get_size(): Int;
    public function set_size( v: Int ): Int;
}
