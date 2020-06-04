package trilateral3.drawing;
import trilateral3.drawing.TriangleType;
@:forward
abstract Color3Abstract( Color3Type ) to Color3Type from Color3Type {
    public inline function new( color3Type: Color3Type ){
        this = color3Type;
    }
    public var argb( never, set ): Int;
    inline
    function set_argb( col: Int ): Int {
        return this.set_argb( col );
    }
    
    
    public var argbA( get, set ): Int;
    inline
    function set_argbA( col: Int ): Int {
        return this.set_argbA( col );
    }
    inline
    function get_argbA():Int {
        return this.get_argbA();
    }
    public var argbB( get, set ): Int;
    inline
    function set_argbB( col: Int ): Int {
        return this.set_argbB( col );
    }
    inline
    function get_argbB():Int {
        return this.get_argbB();
    }
    public var argbC( get, set ): Int;
    inline
    function set_argbC( col: Int ): Int {
        return this.set_argbC( col );
    }
    inline
    function get_argbC(): Int {
        return this.get_argbC();
    }
}