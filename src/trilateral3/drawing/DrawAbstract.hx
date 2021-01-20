package trilateral3.drawing;
@:forward
abstract DrawAbstract( DrawType ) to DrawType from DrawType {
    public inline function new( drawType: DrawType ){
        this = drawType;
    }
    public var pos( get, set ): Float ;
    inline function get_pos(): Float {
        return this.get_pos();
    }
    inline function set_pos( v: Float ): Float {
        this.set_pos( v );
        return v; 
    }
    public var size( get, set ): Int;
    inline function set_size( v: Int ): Int {
        this.set_size( v );
        return v;
    }
    inline function get_size(): Int {
        return this.get_size();
    }    
    inline function toStart( v: Int, len: Int ): Bool {
        return this.toStart( v, len );
    }
    inline function toEnd( v: Int, len: Int ): Bool {
        return this.toEnd( v, len );
    }
}
