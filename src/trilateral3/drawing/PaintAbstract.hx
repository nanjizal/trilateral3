package trilateral3.drawing;
@:forward
abstract PaintAbstract( PaintType ) to PaintType from PaintType {
    public inline function new( paintType: PaintType ){
        this = paintType;
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
    public inline
    function toStart( v: Int, len: Int ): Bool {
        return this.toStart( v, len );
    }
    public inline
    function toEnd( v: Int, len: Int ): Bool {
        return this.toEnd( v, len );
    }
    public inline
    function swap( v0: Int, v1: Int, len: Int ): Bool {
        return this.swap( v0, v1, len );
    }
}