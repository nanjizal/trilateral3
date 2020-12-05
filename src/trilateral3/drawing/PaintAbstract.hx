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
}