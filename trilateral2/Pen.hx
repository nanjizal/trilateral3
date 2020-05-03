package trilateral2;
import trilateral2.DrawAbstract;
import trilateral2.ColorAbstract;
import geom.flat.f32.Float32FlatRGBA;
import geom.flat.f32.Float32FlatTriangle;
import geom.obj.Tri3D;
import geom.matrix.Matrix4x3;
class Pen {
    public var rounded: Float = 30; // default value... change
    public var dz: Float = 0.01; // default value... change
    public var currentColor: Int = 0xFACADE; // Classic Rose 
    public var drawType:  DrawAbstract;
    public var colorType: ColorAbstract;
    public var indices:   Array<Int> = [];
    public var transformMatrix: Matrix4x3;
    public function new( drawType_: DrawAbstract, colorType_: ColorAbstract ){
        drawType  = drawType_;
        colorType = colorType_;
    }
    // normal WebGL implementation using Float32Flat's, but Pen would accept alternate implementation
    //@:access(geom.flat.f32.Float32FlatTriangle,geom.flat.f32.Float32FlatRGBA)
    
    public static inline 
    function create(    verts: Float32FlatTriangle
                      , cols:  Float32FlatRGBA ): Pen {
        @:privateAccess
        return new Pen( {  triangle:          verts.triangle
                            , transform:      verts.transform
                            , transformRange: verts.transformRange
                            , getTri3D:       verts.getTri3D
                            , next:           verts.next
                            , hasNext:        verts.hasNext
                            , get_pos:        verts.get_pos
                            , set_pos:        verts.set_pos
                            , get_size:       verts.get_size
                            , set_size:       verts.set_size
                            }
                          , { cornerColors:   cols.cornerColors
                            , colorTriangles: cols.colorTriangles
                            , get_pos:        verts.get_pos
                            , set_pos:        verts.set_pos
                            , get_size:       verts.get_size
                            , set_size:       verts.set_size
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
        drawType.pos  = v;
        colorType.pos = v;
        return v;
    }
}
