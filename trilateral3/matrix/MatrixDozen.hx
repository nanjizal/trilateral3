package trilateral3.matrix;

#if nanjizal_geom 
import geom.structure.Mat4x3;
typedef MatrixDozen = geom.matrix.Mat4x3;
#else
@:structInit
class MatrixDozen {
    public var a = 0.; public var b = 0.; public var c = 0.; public var d = 0.;
    public var e = 0.; public var f = 0.; public var g = 0.; public var h = 0.;
    public var i = 0.; public var j = 0.; public var k = 0.; public var l = 0.;
    function new( a: Float, b: Float, c: Float, d: Float
                , e: Float, f: Float, g: Float, h: Float
                , i: Float, j: Float, k: Float, l: Float ){
        this.a = a; this.b = b; this.c = c; this.d = d;
        this.e = e; this.f = f; this.g = g; this.h = h;
        this.i = i; this.j = j; this.k = k; this.l = l;
    }
}
#end