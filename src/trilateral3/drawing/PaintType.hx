package trilateral3.drawing; 
import trilateral3.matrix.MatrixDozen;
import trilateral3.structure.Triangle3D;
import trilateral3.structure.TriangleUV;
import trilateral3.drawing.TriangleAbstract;
import trilateral3.structure.TriInt;
import trilateral3.drawing.Color3Abstract;
import trilateral3.shape.IteratorRange;
typedef PaintType = {
    var triangle: ( ax_: Float, ay_: Float, az_: Float
                  , bx_: Float, by_: Float, bz_: Float
                  , cx_: Float, cy_: Float, cz_: Float ) -> Bool;
    var ?triangleUV: ( uA_: Float, vA_: Float
                     , uB_: Float, vB_: Float
                     , uC_: Float, vC_: Float
                     , ?windAdjust_: Null<Bool> ) -> Bool;
    var cornerColors: ( colorA: Int, colorB: Int, colorC: Int ) -> Void;
    var colorTriangles: ( color: Int, times: Int ) -> Void;
    var getTriInt:()->TriInt;
    var getTriangle3D:()->Triangle3D;
    var ?getTriangleUV:()->TriangleUV;
    var transform: ( MatrixDozen ) -> Void;
    var transformRange: ( m: MatrixDozen, startEnd: IteratorRange ) -> Void;
    var next: ()->Float;
    var hasNext: ()->Bool;
    var ?triangleCurrent:   TriangleAbstract;
    var ?triangleCurrentUV: TriangleAbstractUV;
    public function get_pos(): Float;
    public function set_pos( v: Float ): Float;
    public function get_size(): Int;
    public function set_size( v: Int ): Int;
    public function toStart( v: Int, len: Int ): Bool;
    public function toEnd( v: Int, len: Int ): Bool;
    public function swap( v0: Int, v1: Int, len: Int ): Bool;
    // Only relevant when using interleave array structures
    var ?color3current: Color3Abstract;
}