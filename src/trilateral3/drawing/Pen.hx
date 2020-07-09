package trilateral3.drawing;
import trilateral3.drawing.DrawAbstract;
import trilateral3.drawing.ColorAbstract;
import trilateral3.drawing.TriangleAbstract;
import trilateral3.drawing.Color3Abstract;
import trilateral3.shape.IndexRange;
import trilateral3.geom.FlatColorTriangles;
import trilateral3.matrix.Vertex;
import trilateral3.matrix.MatrixDozen;
import trilateral3.geom.Transformer;
import trilateral3.structure.Triangle3D;
import trilateral3.structure.TriInt;
import trilateral3.structure.XYWH;
#if cpp
import cpp.Float32;
#end
class Pen {
    public var useTexture:   Bool = false;
    var textureFX:     Float = 1./1000.;
    var textureFY:     Float = 1./1000.;
    public var rounded:      Float = 30; // default value... change
    public var dz:           Float = 0.01; // default value... change
    public var currentColor: Int   = 0xFACADE; // Classic Rose 
    public var drawType:     DrawAbstract;
    public var colorType:    ColorAbstract;
    public var translateX:   Float -> MatrixDozen;
    public var translateY:   Float -> MatrixDozen;
    public var translateZ:   Float -> MatrixDozen;
    public var rotateX:      Float -> MatrixDozen;
    public var rotateY:      Float -> MatrixDozen;
    public var rotateZ:      Float -> MatrixDozen;
    public var indices:      Array<Int> = [];
    public function new( drawType_: DrawAbstract, colorType_: ColorAbstract ){
        drawType  = drawType_;
        colorType = colorType_;
    }
    public inline
    function transformRange( trans: MatrixDozen, ir: IndexRange ) {
        this.drawType.transformRange( trans, ir );
    }
    public var textureXYWH( never, set ): XYWH;
    inline
    function set_textureXYWH( r: XYWH ): XYWH {
        textureFX = r.x/r.w;
        textureFY = r.y/r.h;
        return r;
    }
    public inline
    function up( ir: IndexRange ){
        var trans = translateZ( dz/2 );
        transformRange( trans, ir );
    }
    public inline
    function down( ir: IndexRange ){
        var trans = translateZ( -dz/2 );
        transformRange( trans, ir );
    }
    public inline
    function back( ir: IndexRange ){
        transformRange( transBack(), ir );
    }
    inline
    function transBack(): MatrixDozen    {
        return multiplyTransform( rotateX( Math.PI ), translateX( dz ) );
    }
    /*
    public static inline 
    function create(    tri: FlatColorTriangle ): Pen {
        @:privateAccess
        return new Pen( {  triangle:          tri.triangle
                            , transform:      tri.transform
                            , transformRange: tri.transformRange
                            , getTriangle3D:  tri.getTriangle3D
                            , next:           tri.next
                            , hasNext:        tri.hasNext
                            , get_pos:        tri.get_pos
                            , set_pos:        tri.set_pos
                            , get_size:       tri.get_size
                            , set_size:       tri.set_size
                            }
                          , { cornerColors:   tri.cornerColors
                            , colorTriangles: tri.colorTriangles
                            , getTriInt:   tri.getTriInt
                            , get_pos:        tri.get_pos
                            , set_pos:        tri.set_pos
                            , get_size:       tri.get_size
                            , set_size:       tri.set_size
                            } 
                        );
    }
    */
    inline public
    function cornerColor( color: Int = -1 ): Void {
        if( color == -1 ) color = currentColor;
        colorType.cornerColors( color, color, color );
    }
    inline public
    function cornerColors( colorA: Int, colorB: Int, colorC: Int ): Void {
        colorType.cornerColors( colorA, colorB, colorC );
    }
    inline public
    function middleColor( color: Int, colorCentre: Int ): Void {
        colorType.cornerColors( colorCentre, color, color );
    }
    inline public
    function middleColors( color: Int, colorCentre: Int, times: Int ): Void {
        for( i in 0...times ){
            middleColor( color, colorCentre );
        }
    }
    inline public
    function colorTriangles( color: Int, times: Int ): Void {
        if( color == -1 ) color = currentColor;
        colorType.colorTriangles( color, times );
    }
    #if cpp
    inline public
    function addTriangle( ax: Float32, ay: Float32, az: Float32
                        , bx: Float32, by: Float32, bz: Float32
                        , cx: Float32, cy: Float32, cz: Float32 ){
        // don't need to reorder corners and Trilateral can do that!
        var windAdjust = drawType.triangle( ax, ay, az, bx, by, bz, cx, cy, cz );
        if( Trilateral.transformMatrix != null ) drawType.transform( Trilateral.transformMatrix );
        if( useTexture ) {
            ax -= textureFX;
            ay -= textureFY;
            drawType.triangleUV( ( ax + 0.5 )/2., ( ay + 0.5 )/2.
                               , ( bx + 0.5 )/2., ( by + 0.5 )/2.
                               , ( cx + 0.5 )/2., ( cy + 0.5 )/2.
                               , windAdjust );
        }
        drawType.next();
    }
    #else 
    inline public
    function addTriangle( ax: Float, ay: Float, az: Float
                        , bx: Float, by: Float, bz: Float
                        , cx: Float, cy: Float, cz: Float ){
        // don't need to reorder corners and Trilateral can do that!
        var windAdjust = drawType.triangle( ax, ay, az, bx, by, bz, cx, cy, cz );
        if( Trilateral.transformMatrix != null ) drawType.transform( Trilateral.transformMatrix );
        if( useTexture ) {
            ax -= textureFX;
            ay -= textureFY;
            drawType.triangleUV( ( ax + 0.5 )/2., ( ay + 0.5 )/2.
                               , ( bx + 0.5 )/2., ( by + 0.5 )/2.
                               , ( cx + 0.5 )/2., ( cy + 0.5 )/2.
                               , windAdjust );
        }
        drawType.next();
    }
    #end
    inline public
    function triangle2DFill( ax: Float, ay: Float
                          , bx: Float, by: Float
                          , cx: Float, cy: Float
                          , color: Int = -1 ): Int {
        // if no color set use current default colour.
        if( color == -1 ) color = currentColor;
        addTriangle( ax, ay, 0, bx, by, 0, cx, cy, 0 );
        cornerColors( color, color, color ); // next
        return 1; 
    }
    public var pos( get, set ): Float;
    inline 
    function get_pos(): Float {
        return drawType.pos;
    }
    inline
    function set_pos( v: Float ){
        drawType.pos  = v;
        colorType.pos = v;
        return v;
    }
    /**
     * Only optionally available use with care, works with PenNodule.
     */
    public var triangleCurrent( get, never ): TriangleAbstract;
    inline
    function get_triangleCurrent(): TriangleAbstract {
        return drawType.triangleCurrent;
    } 
    /**
     * Only possible if using interleave data structure !! use with care.
     */
    public var color3Current( get, never ): Color3Abstract;
    inline
    function get_color3Current(): Color3Abstract {
        return colorType.color3current;
    } 
    inline public
    function copyRange( otherPen: Pen, startEnd: IndexRange, vec: Vertex ): IndexRange     {
        var start = this.pos;
        otherPen.pos = startEnd.start;
        var colors: TriInt;
        for( i in startEnd.start...(startEnd.end+1) ){
            var tri: Triangle3D = otherPen.drawType.getTriangle3D();
            this.drawType.triangle( tri.a.x + vec.x, tri.a.y + vec.y, tri.a.z + vec.z
                       , tri.b.x + vec.x, tri.b.y + vec.y, tri.b.z + vec.z
                       , tri.c.x + vec.x, tri.c.y + vec.y, tri.c.z + vec.z );
            this.drawType.next();
            //colors = otherPen.colorType.getTriInt();
            //cornerColors( colors.a, colors.b, colors.c );
        }
        var end = Std.int( this.pos - 1 );
        var s0: IndexRange = { start: Std.int( start ), end: end };
        return s0;
    }
}
