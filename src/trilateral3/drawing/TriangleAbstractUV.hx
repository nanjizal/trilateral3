package trilateral3.drawing;
import trilateral3.drawing.TriangleTypeUV;
@:forward
abstract TriangleAbstractUV( TriangleTypeUV ) to TriangleTypeUV from TriangleTypeUV {
    public inline function new( triangleTypeUV: TriangleTypeUV ){
        this = triangleTypeUV;
    }
    public var bottomV( get, never ): Float;
    inline function get_bottomV(): Float {
        return this.get_bottomV();
    }
    public var rightU( get, never ): Float;
    inline function get_rightU(): Float {
        return this.get_rightU();
    }
    public var u( get, set ): Float;
    inline function get_u(): Float {
        return this.get_u();
    }
    inline function set_u( u_: Float ): Float {
        return this.set_u( u_ );
    }
    public var v( get, set ): Float;
    inline function get_v(): Float {
        return this.get_v();
    }
    inline function set_v( v_: Float ): Float {
        return this.set_v( v_ );
    }
}