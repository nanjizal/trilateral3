package trilateral3.drawing;
import trilateral3.structure.TriInt;
import trilateral3.drawing.Color3Abstract;
typedef ColorType = {
    var cornerColors: ( colorA: Int, colorB: Int, colorC: Int ) -> Void;
    var colorTriangles: ( color: Int, times: Int ) -> Void;
    var getTriInt:()->TriInt;
    public function get_pos(): Float;
    public function set_pos( v: Float ): Float;
    public function get_size(): Int;
    public function set_size( v: Int ): Int;
    // Only relevant when using interleave array structures
    var ?color3current: Color3Abstract;
}
