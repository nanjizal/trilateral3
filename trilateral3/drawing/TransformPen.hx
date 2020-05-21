package trilateral3.shape;
import trilateral3.Pen;
import geom.matrix.Matrix4x3;
import trilateral3.shape.Shaper;

@:forward
abstract TransformPen( Pen ) from Pen to Pen {
    public function new( pen: Pen ){
        this = pen;
    }
    public inline
    function transformRange( trans: Matrix4x3, ir: IndexRange ){
        this.drawType.transformRange( trans, ir.start, ir.end );
    }
    public inline
    function up( ir: IndexRange ){
        var trans = Matrix4x3.unit.translateZ( this.dz/2 );
        transformRange( trans, ir );
    }
    public inline
    function down( ir: IndexRange ){
        var trans = Matrix4x3.unit.translateZ( -this.dz/2 );
        transformRange( trans, ir );
    }
    public inline
    function back( ir: IndexRange ){
        transformRange( transBack(), ir );
    }
    inline
    function transBack(): Matrix4x3 {
        return Matrix4x3.unit.rotateX( Math.PI ) * Matrix4x3.unit.translateX( this.dz );
    }
    inline public
    function copyRange( otherPen: Pen, startEnd: IndexRange, vec: Matrix1x4 ): IndexRange {
        var start = pos;
        otherPen.pos = startEnd.start;
        var colors: TriColors;
        for( i in startEnd.start...(startEnd.end+1) ){
            var tri: Tri3D = otherPen.drawType.getTri3D();
            drawType.triangle( tri.a.x + vec.x, tri.a.y + vec.y, tri.a.z + vec.z
                       , tri.b.x + vec.x, tri.b.y + vec.y, tri.b.z + vec.z
                       , tri.c.x + vec.x, tri.c.y + vec.y, tri.c.z + vec.z );
            drawType.next();
            //colors = otherPen.colorType.getTriColors();
            //cornerColors( colors.a, colors.b, colors.c );
        }
        var end = Std.int( pos - 1 );
        var s0: IndexRange = { start: Std.int( start ), end: end };
        return s0;
    }
    inline public
    function copyRange2( otherPen: Pen, startEnd: IndexRange, vec: Matrix1x4 ): IndexRange {
        var start = pos;
        otherPen.pos = startEnd.start;
        var colors: TriColors;
        for( i in startEnd.start...(startEnd.end+1) ){
            var tri: Tri3D = otherPen.drawType.getTri3D();
            addTriangle( tri.a.x + vec.x, tri.a.y + vec.y, tri.a.z + vec.z
                       , tri.b.x + vec.x, tri.b.y + vec.y, tri.b.z + vec.z
                       , tri.c.x + vec.x, tri.c.y + vec.y, tri.c.z + vec.z );
            //drawType.next();
            //colors = otherPen.colorType.getTriColors();
            //cornerColors( colors.a, colors.b, colors.c );
        }
        var end = Std.int( pos - 1 );
        var s0: IndexRange = { start: Std.int( start ), end: end };
        return s0;
    }
}