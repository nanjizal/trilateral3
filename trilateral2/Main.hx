package;
import js.Browser;
import htmlHelper.webgl.WebGLSetup;
import htmlHelper.tools.CharacterInput;
import js.html.Event;
import js.html.KeyboardEvent;
import js.html.MouseEvent;
import js.html.DivElement;
import htmlHelper.tools.AnimateTimer; 
import shaders.Shaders;
import geom.Matrix4x3;
import geom.Matrix4x4;
import geom.Quaternion;
import geom.DualQuaternion;
import geom.Matrix1x4;
import geom.Axis;
import geom.Trinary;
import geom.Projection;
import geom.Matrix1x2;
import js.lib.Float32Array;
import trilateral2.Algebra;
import trilateral2.Pen;
import trilateral2.DrawType;
import trilateral2.ColorType;
import flat.Float32FlatRGBA;
import flat.Float32FlatTriangle;
import trilateral2.Shaper;
import trilateral2.Contour;
import trilateral2.EndLineCurve;
import trilateral2.Sketch;
import trilateral2.SketchForm;
import LayoutPos;
import DivertTrace;
import justPath.*;
import justPath.transform.ScaleContext;
import justPath.transform.ScaleTranslateContext;
import justPath.transform.TranslationContext;
import pallette.QuickARGB;
using htmlHelper.webgl.WebGLSetup;
class Main extends WebGLSetup {
    var webgl:                  WebGLSetup;
    public var axisModel               = new Axis();
    var scale:                  Float;
    var model                   =  DualQuaternion.zero();
    var pen:                    Pen;
    var theta:                  Float = 0;
    var centre:                 Matrix1x2;
    var bottomLeft:             Matrix1x2;
    var bottomRight:            Matrix1x2;
    var topLeft:                Matrix1x2;
    var topRight:               Matrix1x2;
    var quarter:                Float;
    var toDimensionsGL:         Matrix4x3;
    var verts                   = new Float32FlatTriangle(1000000);
    var cols                    = new Float32FlatRGBA(1000000);
    var ind                     = new Array<Int>();
    public static function main(){ new Main(); }
    public inline static var stageRadius: Int = 600;
    public function resetPosition():Void{
        model =  DualQuaternion.zero();
    }
    public function new(){
        new DivertTrace();
        trace( 'Trilateral2 Testing' );
        super( stageRadius, stageRadius );
        var axisKeys = new AxisKeys( axisModel );
        axisKeys.reset = resetPosition;
        DEPTH_TEST = false;
        BACK = false;
        scale = 1/(stageRadius);
        darkBackground();
        setupProgram( Shaders.vertex, Shaders.fragment );
        layoutParameters();
        var axisWebGL = Matrix4x3.unit().translateXYZ( 1, -1, 0. );
        var scaleWebGL  = new Matrix1x4( { x: -scale, y: scale, z: 1., w: 1. } );
        // unsure at moment about best order, for current transform order does not matter?
        toDimensionsGL  = scaleWebGL * axisWebGL;// * scaleWebGL; 
        var triFunc = verts.triangle;
        var nextFunc = verts.next;
        pen = new Pen( {  triangle: verts.triangle
                        , next:     verts.next
                        , hasNext:  verts.hasNext
                        , pos:      verts.pos
                        , length:   verts.length }
                      , { cornerColors: cols.cornerColors
                        , colorTriangles: cols.colorTriangles
                        , pos:      verts.pos
                        , length:   verts.length
                        } 
                      );
        cols.pos = 0;
        drawShapes();
        // would be ideal to move this with projection and axis model.
        verts.transformAll( toDimensionsGL );
        cols.pos = 0;
        for( i in 0...verts.length ) {
            ind[ i * 3 ]     = i *3;
            ind[ i * 3 + 1 ] = i *3 + 1;
            ind[ i * 3 + 2 ] = i *3 + 2;
        }
        vertices =  cast verts.getArray();
        colors = cast cols.getArray();
        indices = ind;
        gl.uploadDataToBuffers( program, vertices, colors, indices );
        setAnimate();
    }
    function darkBackground(){
        var dark = 0x18/256;
        bgRed   = dark;
        bgGreen = dark;
        bgBlue  = dark;
    }
    // example of showing flat array data and of the matrix data.
    public function traceFlatData(){
        trace( toDimensionsGL.pretty(5) );
        trace( verts.getArray() );
        trace( cols.hexAll() );
    }
    /*
    inline
    function colorSet( times: Int, color: Int ){
        for( i in 0...times ) pen.colorType.cornerColors( color, color, color );
    }*/
    public function drawShapes(){
        var size = 80;
        var len = 0;
        //pen.color = 
        //var contour = new Contour( pen, EndLineCurve.both );
        pen.currentColor = 0xffff0000;
        var sketch = new Sketch( pen, SketchForm.Fine, EndLineCurve.both );
        sketch.width = 2;
        sketch.widthFunction = function( width: Float, x: Float, y: Float, x_: Float, y_: Float ): Float{
            return width+0.008;
        }
        
        var translateContext = new TranslationContext( sketch, -100, 300 );
        var p = new SvgPath( translateContext );
        p.parse( quadtest_d );
        sketch.colourFunction = function( colour: Int, x: Float, y: Float, x_: Float, y_: Float ):  Int {
            return Math.round( colour-1*x*y );
        }
        pen.currentColor = 0xfffccc00;
        var scaleContent = new ScaleContext( sketch, 1.5, 1.5 );
        var p = new SvgPath( scaleContent );
        p.parse( bird_d );
        
        len = Shaper.rectangle( pen.drawType
                              , 10, 10
                              , size*2, size );
        
        /*len = Shaper.rectangle( pen.drawType
                              , centre.x - 100, centre.y - 50
                              , size*2, size ); */
        
        pen.colorTriangles( Blue, len );
        len = Shaper.overlapStar( pen.drawType
            , ( bottomLeft.x + centre.x )/2, ( bottomLeft.y + centre.y )/2, size  );
        pen.colorTriangles( Orange, len );
        len = Shaper.diamond( pen.drawType
            , ( topLeft.x + centre.x )/2, ( topLeft.y + centre.y )/2,     0.7*size );
        pen.colorTriangles( Yellow, len );
        len = Shaper.square( pen.drawType
                            , ( bottomRight.x + centre.x )/2
                            , ( bottomRight.y + centre.y )/2,  0.7*size );
        pen.colorTriangles( Green, len );
        len = Shaper.squareOutline( pen.drawType
                                    , ( bottomRight.x + centre.x )/2
                                    , ( bottomRight.y + centre.y )/2, 0.7*size, 6 );
        pen.colorTriangles( MidGrey, len );
        len = Shaper.circle( pen.drawType
                           , ( topRight.x + centre.x )/2, ( topRight.y + centre.y )/2
                           ,  size);
        pen.colorTriangles( Indigo, len );
        len = Shaper.roundedRectangle( pen.drawType
                                     , topLeft.x - size
                                     ,( topLeft.y + bottomLeft.y )/2 - size/2, size*2
                                     , size, 30 );
        pen.colorTriangles( Violet, len );
        len = Shaper.roundedRectangleOutline( pen.drawType
                                            , topLeft.x - size
                                            ,( topLeft.y + bottomLeft.y )/2 - size/2
                                            , size*2, size,  6, 30 );
        pen.colorTriangles( Red, len );
    }
    inline
    function render_( i: Int ):Void{        
        //origin = axisOrigin.updateCalculate( origin );
        model  = axisModel.updateCalculate( model );
        var trans: Matrix4x3 = (  offset * model ).normalize();
        var proj4 = ( Projection.perspective() * trans ).updateWebGL( matrix32Array );
        //trace( 'matrix32Array ' + matrix32Array );
        render();
    }
    inline
    function setAnimate(){
        AnimateTimer.create();
        AnimateTimer.onFrame = render_;
    }
    override public 
    function render(){
        super.render();
    }
    inline
    public static 
    function getOffset(): DualQuaternion {
        var qReal = Quaternion.zRotate( Math.PI );
        var qDual = new Matrix1x4( { x: 0., y: 0., z: -1., w: 1. } );
        return DualQuaternion.create( qReal, qDual );
    }
    var offset = getOffset();
    inline public
    function layoutParameters(){
        var layoutPos = new LayoutPos( stageRadius );
        centre          = layoutPos.centre;
        quarter         = layoutPos.quarter;
        bottomLeft      = layoutPos.bottomLeft;
        bottomRight     = layoutPos.bottomRight;
        topLeft         = layoutPos.topLeft;
        topRight        = layoutPos.topRight;
    }
    var quadtest_d = "M200,300 Q400,50 600,300 T1000,300";
    var cubictest_d = "M100,200 C100,100 250,100 250,200S400,300 400,200";
    var bird_d = "M210.333,65.331C104.367,66.105-12.349,150.637,1.056,276.449c4.303,40.393,18.533,63.704,52.171,79.03c36.307,16.544,57.022,54.556,50.406,112.954c-9.935,4.88-17.405,11.031-19.132,20.015c7.531-0.17,14.943-0.312,22.59,4.341c20.333,12.375,31.296,27.363,42.979,51.72c1.714,3.572,8.192,2.849,8.312-3.078c0.17-8.467-1.856-17.454-5.226-26.933c-2.955-8.313,3.059-7.985,6.917-6.106c6.399,3.115,16.334,9.43,30.39,13.098c5.392,1.407,5.995-3.877,5.224-6.991c-1.864-7.522-11.009-10.862-24.519-19.229c-4.82-2.984-0.927-9.736,5.168-8.351l20.234,2.415c3.359,0.763,4.555-6.114,0.882-7.875c-14.198-6.804-28.897-10.098-53.864-7.799c-11.617-29.265-29.811-61.617-15.674-81.681c12.639-17.938,31.216-20.74,39.147,43.489c-5.002,3.107-11.215,5.031-11.332,13.024c7.201-2.845,11.207-1.399,14.791,0c17.912,6.998,35.462,21.826,52.982,37.309c3.739,3.303,8.413-1.718,6.991-6.034c-2.138-6.494-8.053-10.659-14.791-20.016c-3.239-4.495,5.03-7.045,10.886-6.876c13.849,0.396,22.886,8.268,35.177,11.218c4.483,1.076,9.741-1.964,6.917-6.917c-3.472-6.085-13.015-9.124-19.18-13.413c-4.357-3.029-3.025-7.132,2.697-6.602c3.905,0.361,8.478,2.271,13.908,1.767c9.946-0.925,7.717-7.169-0.883-9.566c-19.036-5.304-39.891-6.311-61.665-5.225c-43.837-8.358-31.554-84.887,0-90.363c29.571-5.132,62.966-13.339,99.928-32.156c32.668-5.429,64.835-12.446,92.939-33.85c48.106-14.469,111.903,16.113,204.241,149.695c3.926,5.681,15.819,9.94,9.524-6.351c-15.893-41.125-68.176-93.328-92.13-132.085c-24.581-39.774-14.34-61.243-39.957-91.247c-21.326-24.978-47.502-25.803-77.339-17.365c-23.461,6.634-39.234-7.117-52.98-31.273C318.42,87.525,265.838,64.927,210.333,65.331zM445.731,203.01c6.12,0,11.112,4.919,11.112,11.038c0,6.119-4.994,11.111-11.112,11.111s-11.038-4.994-11.038-11.111C434.693,207.929,439.613,203.01,445.731,203.01z";
}