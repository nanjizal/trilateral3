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
    public function clone(): Triangle3D {
        return { a: this.a.clone(), b: this.b.clone(), c: this.c.clone() };
    }
}