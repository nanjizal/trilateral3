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
   
    public var z2D: Float = 0.; // this is problematic for Shape triangle2d...
    public var useTexture:   Bool = false;
    var textureFX:     Float = 1./1000.;
    var textureFY:     Float = 1./1000.;
    public var rounded:      Float = 30; // default value... change
    public var dz:           Float = 0.01; // default value... change
    public var currentColor: Int   = 0xFACADE; // Classic Rose 
    public var paintType:     PaintAbstract;

    public var translateX:   Float -> MatrixDozen;
    public var translateY:   Float -> MatrixDozen;
    public var translateZ:   Float -> MatrixDozen;
    public var rotateX:      Float -> MatrixDozen;
    public var rotateY:      Float -> MatrixDozen;
    public var rotateZ:      Float -> MatrixDozen;
    public var indices:      Array<Int> = [];
    public function new( paintType_: PaintAbstract ){
        paintType  = paintType_;
    }
    public inline
    function transformRange( trans: MatrixDozen, ir: IndexRange ) {
        this.paintType.transformRange( trans, ir );
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
        paintType.cornerColors( color, color, color );
    }
    inline public
    function cornerColors( colorA: Int, colorB: Int, colorC: Int ): Void {
        paintType.cornerColors( colorA, colorB, colorC );
    }
    inline public
    function middleColor( color: Int, colorCentre: Int ): Void {
        paintType.cornerColors( colorCentre, color, color );
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
        paintType.colorTriangles( color, times );
    }
    #if cpp
    public inline
    function addTriangle( ax: Float32, ay: Float32, az: Float32
                        , bx: Float32, by: Float32, bz: Float32
                        , cx: Float32, cy: Float32, cz: Float32 ){
        // don't need to reorder corners and Trilateral can do that!
        var windAdjust = paintType.triangle( ax, ay, az, bx, by, bz, cx, cy, cz );
        if( Trilateral.transformMatrix != null ) paintType.transform( Trilateral.transformMatrix );
        if( useTexture ) {
            ax = ax/2000;
            ay = ay/2000;
            bx = bx/2000;
            by = by/2000;
            cx = cx/2000;
            cy = cy/2000;
            paintType.triangleUV( ax, ay
                               , bx, by
                               , cx, cy
                               , windAdjust );
        }
        //drawType.next();
    }
    #else 
    public inline 
    function addTriangle( ax: Float, ay: Float, az: Float
                        , bx: Float, by: Float, bz: Float
                        , cx: Float, cy: Float, cz: Float ){
        // don't need to reorder corners and Trilateral can do that!
        var windAdjust = paintType.triangle( ax, ay, az, bx, by, bz, cx, cy, cz );
        if( Trilateral.transformMatrix != null ) paintType.transform( Trilateral.transformMatrix );
        if( useTexture ) {
            ax = ax/2000;
            ay = ay/2000;
            bx = bx/2000;
            by = by/2000;
            cx = cx/2000;
            cy = cy/2000;
            paintType.triangleUV( ax, ay
                               , bx, by
                               , cx, cy
                               , windAdjust );
        }
        //drawType.next();
    }
    #end
    inline public
    function triangle2DFill( ax: Float, ay: Float
                          , bx: Float, by: Float
                          , cx: Float, cy: Float
                          , color: Int = -1 ): Int {
        // if no color set use current default colour.
        if( color == -1 ) color = currentColor;
        addTriangle( ax, ay, z2D, bx, by, z2D, cx, cy, z2D );
        cornerColors( color, color, color ); // next
        paintType.next();
        return 1; 
    }
    // 1 2 3
    // 4 5 6
    // 7 8 9
    // borders from outside left, right, top, bottom
    public inline
    function nineSliceFill( ax: Float, ay: Float, width: Float, height: Float
                      , left: Float, right: Float
                      , top: Float, bottom: Float
                      , color0: Int = -1, color1: Int = -1, color2: Int = -1
                      , color3: Int = -1, color4: Int = -1, color5: Int = -1
                      , color6: Int = -1, color7: Int = -1, color8: Int = -1 ){
        quad2DFill( ax, ay, left, top, color0 );
        var middleW = width - left - right;
        quad2DFill( ax + left, ay, middleW, top, color1 );
        quad2DFill( ax + middleW, ay, right, top, color2 );
        
        var middleH = height - top - bottom;
        quad2DFill( ax , ay + top, left, middleH, color3 );
        quad2DFill( ax + left, ay + top, middleW, middleH, color4 );
        quad2DFill( ax + middleW, ay + top, right, middleH, color5 );
        
        var bottomH = ax + height - bottom;
        quad2DFill( ax, bottomH, left, bottom, color6 );
        quad2DFill( ax + left, bottomH, middleW, bottom, color7 );
        quad2DFill( ax + middleW, bottomH, right, bottom, color8 );
        return 18;
    }
    public inline
    function quad2DFill( ax: Float, ay: Float, width: Float, height: Float, color: Int = -1 ): Int {
        quad2DFillclockwise( ax, ay, ax + width, ay, ax + width, ay + height, ax, ay + height, color );
        return 2;
    }
    //   A   B
    //   D   C
    // A B D
    // B C D
    public inline
    function quad2DFillclockwise( ax: Float, ay: Float
                                , bx: Float, by: Float
                                , cx: Float, cy: Float
                                , dx: Float, dy: Float
                                , color: Int = -1 ): Int {
        triangle2DFill( ax, ay, bx, by, dx, dy, color );
        triangle2DFill( bx, by, cx, cy, dx, dy, color );
        return 2;
    }
    public var pos( get, set ): Float;
    inline 
    function get_pos(): Float {
        return paintType.pos;
    }
    inline
    function set_pos( v: Float ){
        paintType.pos  = v;
        //colorType.pos = v; assumes they are same
        return v;
    }
    /**
     * Only optionally available use with care, works with PenNodule.
     */
    public var triangleCurrent( get, never ): TriangleAbstract;
    inline
    function get_triangleCurrent(): TriangleAbstract {
        return paintType.triangleCurrent;
    } 
    /**
     * Only optionally available use with care, works with PenNoduleUV.
     */
    public var triangleCurrentUV( get, never ): TriangleAbstractUV;
    inline
    function get_triangleCurrentUV(): TriangleAbstractUV {
        return paintType.triangleCurrentUV;
    } 
    /**
     * Only possible if using interleave data structure !! use with care.
     */
    public var color3Current( get, never ): Color3Abstract;
    inline
    function get_color3Current(): Color3Abstract {
        return paintType.color3current;
    } 
    inline public
    function copyRange( otherPen: Pen, startEnd: IndexRange, vec: Vertex ): IndexRange     {
        var start = this.pos;
        otherPen.pos = startEnd.start;
        var colors: TriInt;
        for( i in startEnd.start...(startEnd.end+1) ){
            var tri: Triangle3D = otherPen.paintType.getTriangle3D();
            this.paintType.triangle( tri.a.x + vec.x, tri.a.y + vec.y, tri.a.z + vec.z
                       , tri.b.x + vec.x, tri.b.y + vec.y, tri.b.z + vec.z
                       , tri.c.x + vec.x, tri.c.y + vec.y, tri.c.z + vec.z );
            this.paintType.next();
            //colors = otherPen.colorType.getTriInt();
            //cornerColors( colors.a, colors.b, colors.c );
        }
        var end = Std.int( this.pos - 1 );
        var s0: IndexRange = { start: Std.int( start ), end: end };
        return s0;
    }
}
