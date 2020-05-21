package trilateral3.drawing;
@:forward
abstract ColorAbstract( ColorType ) to ColorType from ColorType {
    public inline function new( colorType: ColorType ){
        this = colorType;
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
}
