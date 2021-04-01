package trilateral3.matrix;
// copy import string
// import trilateral3.matrix.Vertex;
/** 
   { x, y, z, w }
**/

#if nanjizal_geom 
import geom.structure.Mat1x4;
typedef Vertex = geom.structure.Mat1x4;
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
    public function clone(): Vertex {
        return { x: this.x, y: this.y, z: this.z, w: this.w };
    }
}
#end