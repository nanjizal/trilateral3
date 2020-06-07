package trilateral3.structure;
/** 
   { a, r, g, b }
**/
@:structInit
class ARGB {
    public var a = 0.; 
    public var r = 0.;
    public var g = 0.;
    public var b = 0.;
    public function new( a: Float, r: Float, g: Float, b: Float ){
        this.a = a; 
        this.r = r;
        this.g = g;
        this.b = b;
    }
}