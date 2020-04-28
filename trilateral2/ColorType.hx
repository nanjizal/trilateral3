package trilateral2; 
typedef ColorType = {
    var cornerColors: ( colorA: Int, colorB: Int, colorC: Int ) -> Void;
    var colorTriangles: ( color: Int, times: Int ) -> Void;
    function get_pos(): Float;
    function set_pos( v: Float ): Float;
    function get_size(): Int;
    function set_size( v: Int ): Int;
}
