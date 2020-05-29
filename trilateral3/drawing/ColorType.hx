package trilateral3.drawing;
import trilateral3.structure.TriInt;
typedef ColorType = {
    var cornerColors: ( colorA: Int, colorB: Int, colorC: Int ) -> Void;
    var colorTriangles: ( color: Int, times: Int ) -> Void;
    var getTriInt:()->TriInt;
    function get_pos(): Float;
    function set_pos( v: Float ): Float;
    function get_size(): Int;
    function set_size( v: Int ): Int;
}
