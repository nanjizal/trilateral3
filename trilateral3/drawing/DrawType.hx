package trilateral3.drawing; 
import trilateral3.matrix.MatrixDozen;
import trilateral3.structure.Triangle3D;
import trilateral3.shape.IndexRange;
typedef DrawType = {
    var triangle: ( ax_: Float, ay_: Float, az_: Float
                  , bx_: Float, by_: Float, bz_: Float
                  , cx_: Float, cy_: Float, cz_: Float ) -> Bool;
    var getTriangle3D:()->Triangle3D;
    var transform: ( MatrixDozen ) -> Void;
    var transformRange: ( m: MatrixDozen, startEnd: IndexRange ) -> Void;
    var next: ()->Float;
    var hasNext: ()->Bool;
    public function get_pos(): Float;
    public function set_pos( v: Float ): Float;
    public function get_size(): Int;
    public function set_size( v: Int ): Int;
}
