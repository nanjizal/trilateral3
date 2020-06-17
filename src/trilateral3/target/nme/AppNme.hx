package trilateral3.target.nme;
import flash.Lib;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;
import flash.display.Graphics;
import flash.Vector;
import trilateral3.Trilateral;
import trilateral3.drawing.Pen;
import trilateral3.nodule.PenNodule;
import trilateral3.geom.FlatColorTriangles;
class AppNme extends Sprite {
    public var pen: Pen;
    public var nodule = new PenNodule( false ); // same as PenNodule without transform.
    public var tri: FlatColorTriangles;
    var g:                  Graphics;
    var viewSprite:         Sprite;
    #if flash
    var _vertices   = new Array<Float>();
    //var _tex        = new Array<Float>();
    var _cols       = new Array<Int>();
    var _indices    = new Array<Int>();
    #else
    var _vertices   = new nme.Vector<Float>();// better to fix these to a length?
    //var _tex        = new nme.Vector<Float>();
    var _cols       = new nme.Vector<Int>();
    var _indices    = new nme.Vector<Int>();
    #end
    public static function main(): Void { Lib.current.addChild( new AppNme() ); }
    public
    function new(){
        super();
        internalSetup();
        animate();
        firstDraw();
    }
    inline
    function internalSetup(){
        viewSprite = new Sprite();
        g = viewSprite.graphics;
        addChild( viewSprite );
        pen     = nodule.pen;
        tri     = nodule.colorTriangles;
        initArrays();
    }
    inline
    function animate(){
        addEventListener( Event.ENTER_FRAME, this_onEnterFrame );
    }
    inline
    function firstDraw(){
        draw();
        internalDraw();
    }    
    // override
    public
    function draw(){
        // draw stuff once
    }
    inline
    function render(){
        draw();
        internalDraw();
    }
    inline
    function internalDraw(){
        var s = 1.;
        var ox = -1.;
        var oy = 1.;
        g.clear();
        reset();
        var currPos = tri.pos;
        var posV = 0;
        var posC = 0;
        for( i in 0...nodule.size ){
             tri.pos = i; // change the position.
             _vertices[ posV ]     = tri.ax;
             _vertices[ posV + 1 ] = tri.ay;
             _vertices[ posV + 2 ] = tri.bx;
             _vertices[ posV + 3 ] = tri.by;
             _vertices[ posV + 4 ] = tri.cx;
             _vertices[ posV + 5 ] = tri.cy;
             _cols[ posC ]         = tri.argbA;
             _cols[ posC + 1 ]     = tri.argbB;
             _cols[ posC + 2 ]     = tri.argbC;
             _indices[ posC ]      = posC;
             _indices[ posC + 1 ]  = posC + 1;
             _indices[ posC + 2 ]  = posC + 2;
             posV += 6;
             posC += 3;
         } 
         // reset pos afterwards probably not need
         tri.pos = currPos;
         drawBufferGradient();
    }
    inline
    function initArrays(){
        #if flash
        _vertices   = new Array<Float>();
        //_tex        = new Array<Float>();
        _cols       = new Array<Int>();
        _indices    = new Array<Int>();
        #else
        _vertices   = new nme.Vector<Float>();// better to fix these to a length?
        //_tex        = new nme.Vector<Float>();
        _cols       = new nme.Vector<Int>();
        _indices    = new nme.Vector<Int>();
        #end
    }
    inline
    function reset(){
        #if flash
        _vertices.resize(0);
        //_tex.resize(0);
        _cols.resize(0);
        _indices.resize(0);
        #else
        _vertices.length = 0;
        //_tex.length      = 0;
        _cols.length     = 0;
        _indices.length  = 0;
        #end
    }
    inline
    function drawBufferGradient(){
        g.drawTriangles( _vertices, _indices, null, null, _cols );
    }
    // override
    public
    function drawRender(){
        // draw stuff every frame
    }    
    inline
    function this_onEnterFrame( event: Event ): Void {
        render();
    }
}
#end