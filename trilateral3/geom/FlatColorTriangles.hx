package trilateral3.geom;
//import trilateral3.geom.flat.Flat3x7;
import dsHelper.flatInterleave.core.Flat3x7;
import trilateral3.structure.Triangle3D;
import trilateral3.matrix.MatrixDozen;
import trilateral3.shape.IndexRange;
import trilateral3.matrix.Vertex;
import trilateral3.geom.Transformer;
import trilateral3.structure.TriInt;
import dsHelper.flatInterleave.FloatColorTriangles;
@:forward
abstract FlatColorTriangles( dsHelper.flatInterleave.FloatColorTriangles ){
    public inline function new( len: Int ){
        this = new FloatColorTriangles( len );
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
    public inline
    function getTriInt(): TriInt {
        return { a: this.argbA, b: this.argbB, c: this.argbC };
    }
}