package trilateral3.geom;
import trilateral3.structure.Triangle3D;
import trilateral3.matrix.MatrixDozen;
import trilateral3.shape.IndexRange;
import trilateral3.matrix.Vertex;
import trilateral3.geom.Transformer;
import trilateral3.structure.TriInt;
import dsHelper.flat.f32.Float32FlatTriangle;

#if useHyperKitGL
import hyperKitGL.io.Float32FlatTriangle;
import hyperKitGL.io.Float32Array;
#else
import dsHelper.flat.f32.Float32FlatTriangle;
import dsHelper.haxe.io.Float32Array;
#end

@:transitive
@:forward
abstract FlatTriangles( Float32FlatTriangle ){
    public inline function new( len: Int ){
        this = new Float32FlatTriangle( len );
    }
    public
    function transform( m: MatrixDozen ){
        var pa: Vertex = { x: this.ax, y: this.ay, z: this.az, w: 1. };
        var pb: Vertex = { x: this.bx, y: this.by, z: this.bz, w: 1. };
        var pc: Vertex = { x: this.cx, y: this.cy, z: this.cz, w: 1. };
        pa = transformVertex( pa, m );
        pb = transformVertex( pb, m );
        pc = transformVertex( pc, m );
        this.ax = pa.x;
        this.ay = pa.y;
        this.az = pa.z;
        this.bx = pb.x;
        this.by = pb.y;
        this.bz = pb.z;
        this.cx = pc.x;
        this.cy = pc.y;
        this.cz = pc.z; 
    }
    public
    function transformAll( m: MatrixDozen ) {
        this.pos = 0;
        for( i in 0...this.size ){
            transform( m );
            this.next();
        }
    }
    public
    function transformRange( m: MatrixDozen, startEnd: IndexRange ){
        var start = startEnd.start;
        var end = startEnd.end;
        this.pos = start;
        if( end > this.size - 1 ) end == this.size - 1;
        for( i in start...( end + 1 ) ){
            transform( m );
            this.next();
        }
    }
    public inline
    function getTriangle3D(): Triangle3D {
        var pa: Vertex = { x: this.ax, y: this.ay, z: this.az, w: 1. };
        var pb: Vertex = { x: this.bx, y: this.by, z: this.bz, w: 1. };
        var pc: Vertex = { x: this.cx, y: this.cy, z: this.cz, w: 1. };
        return { a: pa, b: pb, c: pc };
    }
}