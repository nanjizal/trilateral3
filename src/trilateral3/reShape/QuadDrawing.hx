package trilateral3.reShape;
import trilateral3.structure.RangeEntity;
import trilateral3.shape.IteratorRange;
import trilateral3.reShape.RangeShaper;
import trilateral3.reShape.QuadShaper;
import trilateral3.drawing.Pen;

enum abstract QuadColorFill( Int ){
    var NONE;
    var SOLID_FILL;
    var VERT_COLOR_FILL;
    var HORI_COLOR_FILL;
    var QUAD_COLOR_FILL;
}
class QuadDrawing {
    var pen:                 Pen;
    var posMin:              Int;
    var draw_Shape:          Array<RangeEntity>;
    public var bgQuadFill    = 0x00000000; 
    public function new( pen_: Pen, draw_Shape_: Array<RangeEntity> ){
        pen = pen_;
        draw_Shape = draw_Shape_;
    }
    public function drawBox( x: Float, y: Float, w: Float, h: Float, colorMode: QuadColorFill
                           , color0: Int = 0xFFffFFff
                           , color1: Int = 0xFFffFFff
                           , color2: Int = 0xFFffFFff
                           , color3: Int = 0xFFffFFff ){
        var quadShaper: QuadShaper;
        var quadRange:  IteratorRange;
        posMin = Std.int( pen.pos );
        quadShaper = new QuadShaper( pen );
        switch( colorMode ){
            case NONE:
                quadShaper.drawQuadColor( x, y, w, h );
            case SOLID_FILL:
                quadShaper.drawQuadColor( x, y, w, h, color0 );
            case VERT_COLOR_FILL:
                quadShaper.drawQuadVerticalGrad( x, y, w, h, color0, color1 );
            case HORI_COLOR_FILL:
                quadShaper.drawQuadHorizontalGrad( x, y, w, h, color0, color1 );
            case QUAD_COLOR_FILL:
                quadShaper.drawQuadColors( x, y, w, h, color0, color1, color2, color3 );
        }
        quadRange = posMin...Std.int( pen.pos );
        draw_Shape[ draw_Shape.length ] = { textured: true, range: quadRange, bgColor: bgQuadFill };
        return quadShaper;
    }
}