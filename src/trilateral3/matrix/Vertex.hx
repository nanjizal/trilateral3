package trilateral3.matrix;
/** 
   { x, y, z, w }
**/

#if nanjizal_geom 
import geom.matrix.Mat1x4;
typedef Vertex = geom.matrix.Mat1x4;
#else
@:structInit
class Vertex {
    public var x = 0.; 
    public var y = 0.;
    public var z = 0.; 
    @:optional public var w = 1.;
    function new( x: Float, y: Float, z: Float, w: Float = 1. ){
        this.x = x; 
        this.y = y;
        this.z = z;
        this.w = w;
    }
    // for rough debug, perhaps remove later.
    public function values(){
        return x + ' ' + y + ' ' + z + ' ' + w;
    }
}
#end