package trilateral3.structure;
import trilateral3.structure.XY;
@:structInit
class Quad2D {
    public var a: XY;
    public var b: XY;
    public var c: XY;
    public var d: XY;
    function new( a: XY, b: XY, c: XY, d: XY ){
        this.a = a;
        this.b = b;
        this.c = c;
        this.d = d;
    }
}