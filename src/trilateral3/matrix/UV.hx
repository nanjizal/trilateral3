package trilateral3.matrix;
/** 
   { u, v }
**/

#if nanjizal_geom 
import geom.structure.Mat1x2;
@:forward
abstract UV( geom.structure.Mat1x2 ) from geom.structure.Mat1x2 to geom.structure.Mat1x2 {
    public inline
    function new( u: Float, y: Float ){
        this = { x: u, y: u };
    }
    public var u( get, set ): Float;
    inline
    function get_u(): Float {
        return this.x;
    }
    inline
    function set_u( x: Float ): Float {
        this.x = x;
        return x;
    }
    public var v( get, set ): Float;
    inline
    function get_v(): Float {
        return this.y;
    }
    inline
    function set_v( y: Float ): Float {
        this.y = y;
        return y;
    }
    // for rough debug, perhaps remove later.
    inline
    public function values(){
        return this.x + ' ' + this.y;
    }
}
#else
@:structInit
class UV {
    public var u = 0.; 
    public var v = 0.;
    function new( u: Float, v: Float ){
        this.u = u; 
        this.v = v;
    }
    // for rough debug, perhaps remove later.
    public function values(){
        return u + ' ' + v;
    }
}
#end