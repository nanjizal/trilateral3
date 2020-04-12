package trilateral2;
import trilateral2.DrawType;
import trilateral2.ColorType;
import geom.flat.f32.Float32FlatRGBA;
import geom.flat.f32.Float32FlatTriangle;
import geom.matrix.Matrix4x3;
class Pen {
    public var currentColor: Int = 0xFACADE; // Classic Rose 
    public var drawType:  DrawType;
    public var colorType: ColorType;
    public var indices:   Array<Int> = [];
    public var transformMatrix: Matrix4x3;
    public function new( drawType_: DrawType, colorType_: ColorType ){
        drawType  = drawType_;
        colorType = colorType_;
    }
    // normal WebGL implementation using Float32Flat's, but Pen would accept alternate implementation
    public static inline 
    function create(    verts: Float32FlatTriangle
                      , cols:  Float32FlatRGBA ): Pen {
        return new Pen( {  triangle: verts.triangle
                            , transform:verts.transform
                            , next:     verts.next
                            , hasNext:  verts.hasNext
                            , pos:      verts.pos
                            , length:   verts.length 
                            }
                          , { cornerColors:   cols.cornerColors
                            , colorTriangles: cols.colorTriangles
                            , pos:            verts.pos
                            , length:         verts.length
                            } 
                        );
    }    
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
    function colorTriangles( color: Int, times: Int ): Void {
        if( color == -1 ) color = currentColor;
        colorType.colorTriangles( color, times );
    }
    inline public
    function addTriangle( ax: Float, ay: Float, az: Float
                        , bx: Float, by: Float, bz: Float
                        , cx: Float, cy: Float, cz: Float ){
        // don't need to reorder corners and Trilateral can do that!
        drawType.triangle( ax, ay, az, bx, by, bz, cx, cy, cz );
        if( transformMatrix != null ) drawType.transform( transformMatrix );
        drawType.next();
    }
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
        drawType.pos = v;
        colorType.pos = v;
        return v;
    }
}
