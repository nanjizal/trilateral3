package trilateral3.structure;
import trilateral3.matrix.Vertex;
@:structInit
class Triangle3D {
    public var a: Vertex;
    public var b: Vertex;
    public var c: Vertex;
    function new( a: Vertex, b: Vertex, c: Vertex ){
        this.a = a;
        this.b = b;
        this.c = c;
    }
}