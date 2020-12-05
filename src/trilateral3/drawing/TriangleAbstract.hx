package trilateral3.drawing;
import trilateral3.drawing.TriangleType;
@:forward
abstract TriangleAbstract( TriangleType ) to TriangleType from TriangleType {
    public inline function new( triangleType: TriangleType ){
        this = triangleType;
    }
    public var bottom( get, never ): Float;
    inline function get_bottom(): Float {
        return this.get_bottom();
    }
    public var back( get, never ): Float;
    inline function get_back(): Float {
        return this.get_back();
    }
    public var right( get, never ): Float;
    inline function get_right(): Float {
        return this.get_right();
    }
    public var x( get, set ): Float;
    inline function get_x(): Float {
        return this.get_x();
    }
    inline function set_x( x_: Float ): Float {
        return this.set_x( x_ );
    }
    public var y( get, set ): Float;
    inline function get_y(): Float {
        return this.get_y();
    }
    inline function set_y( y_: Float ): Float {
        return this.set_y( y_ );
    }
    public var z( get, set ): Float;
    inline function get_z(): Float {
        return this.get_z();
    }
    inline function set_z( z_: Float ): Float {
        return this.set_z( z_ );
    }
}
