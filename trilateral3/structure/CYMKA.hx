package trilateral3.structure;
/** 
   { a, r, g, b }
**/
@:structInit
class CYMKA {
    public var c = 0.; 
    public var y = 0.;
    public var m = 0.;
    public var k = 0.;
    @:optional public var a = 1.;
    public function new( c: Float, y: Float, m: Float, k: Float, ?a: Float ){
        this.c = c; 
        this.y = y;
        this.m = m;
        this.k = k;
        if( a != null ) this.a = a;
    }
}