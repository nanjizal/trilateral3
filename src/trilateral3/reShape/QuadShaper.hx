package trilateral3.reShape;
import trilateral3.drawing.Pen;
import trilateral3.reShape.TrianglesShaper;
import trilateral3.structure.XY;
import trilateral3.structure.XY0;
import trilateral3.structure.XYWH;
import trilateral3.structure.WH;

class QuadShaper {
    var tri: TrianglesShaper;
    var pen:         Pen;
    public var lastXY: XY;
    public var lastUV: XY;
    var oldStart:    Int;
    var start:       Int;
    public var name:        String;
    public function new( pen: Pen, start: Int, wid: Float = 1000, hi: Float = 1000 ){
        this.pen        = pen;
        this.start      = start;
        tri  = new TrianglesShaper( pen, wid, hi );
    }
    public var begin( get, set ): Int;
    inline
    function get_begin(): Int {
        return start;
    }
    inline
    function set_begin( val: Int ){
        oldStart = start;
        start = val;
        return start;
    }
    #if trilateral_hitDebug
    public function distHit( x: Float, y: Float ): Float {
        pen.pos = start;
        var dist0 = tri.distHit( x, y );
        pen.pos = start + 1;
        var dist1 = tri.distHit( x, y ); 
        return Math.min( dist0, dist1 );
    }
    #end
    public function fullHit( x: Float, y: Float ){
        var hit = false;
        pen.pos = start;
        hit = tri.fullHit( x, y );
        pen.pos = start + 1;
        if( hit!= true ) hit = tri.fullHit( x, y ); 
        return hit;
    }
    public var visible( never, set ): Bool;
    inline
    function set_visible( val: Bool ): Bool {
        if( val ){
            pen.pos = start;
            tri.show();
            pen.pos = start+1;
            tri.show();
        } else {
            pen.pos = start;
            tri.hide();
            pen.pos = start+1;
            tri.hide();
        }
        return val;
    }
    public var alpha( never, set ): Float;
    inline
    function set_alpha( val: Float ){
        pen.pos = start;
        tri.alpha = val;
        pen.pos = start + 1;
        tri.alpha = val;
        return val;
    }
    public var argb( never, set ): Int;
    inline 
    function set_argb( col: Int ): Int {
        pen.pos = start;
        tri.argb = col;
        pen.pos = start + 1;
        tri.argb = col;
        return col;
    }
    public var xy( get, set ): XY;
    inline function get_xy(): XY {
        pen.pos = start;
        return tri.xy;
    }
    inline function set_xy( val: XY ): XY {
        pen.pos = start;
        #if target.static
        lastXY = { x: tri.x, y: tri.y };
        #else
        if( tri.x != null && tri.y != null ) lastXY = { x: tri.x, y: tri.y };
        #end
        tri.xy = val;
        pen.pos = start+1;
        tri.xy = val;
        return val;
    }
    public var xy0( get, set ): XY0;
    inline function get_xy0(): XY0 {
        pen.pos = start;
        return tri.xy0;
    }
    inline function set_xy0( val: XY0 ): XY0 {
        pen.pos = start;
        #if target.static
        lastXY = { x: tri.x, y: tri.y };
        #else
        if( tri.x != null && tri.y != null ) lastXY = { x: tri.x, y: tri.y };
        #end
        tri.xy0 = val;
        pen.pos = start+1;
        tri.xy0 = val;
        return val;
    }
    public var xy1( get, set ): XY;
    inline function get_xy1(): XY {
        return get_xy();
    }
    inline function set_xy1( val: XY ): XY {
        pen.pos = start;
        #if target.static
        lastXY = { x: tri.x, y: tri.y };
        #else
        if( tri.x != null && tri.y != null ) lastXY = { x: tri.x, y: tri.y };
        #end
        tri.xy1 = val;
        pen.pos = start+1;
        tri.xy1 = val;
        return val;
    }
    public var xy2( get, set ): XY;
    inline function get_xy2(): XY {
        return get_xy();
    }
    inline function set_xy2( val: XY ): XY {
        pen.pos = start;
        #if target.static
        lastXY = { x: tri.x, y: tri.y };
        #else
        if( tri.x != null && tri.y != null ) lastXY = { x: tri.x, y: tri.y };
        #end 
        tri.xy2 = val;
        pen.pos = start+1;
        tri.xy2 = val;
        return val;
    }
    public var uv( get, set ): XY;
    inline function get_uv(): XY {
        pen.pos = start;
        return tri.uv;
    }
    inline function set_uv( val: XY ): XY {
        pen.pos = start;
        #if target.static
        lastUV = { x: tri.u, y: tri.v };
        #else
        if( tri.u != null && tri.v != null ) lastUV = { x: tri.u, y: tri.v };
        #end
        tri.uv = val;
        pen.pos = start+1;
        tri.uv = val;
        return val;
    }
    // add setter change type?
    public function setXYWH( xywh: { x: Float, y: Float, w: Float, h: Float } ){
        var ax = xywh.x;
        var ay = xywh.y;
        var bx = ax + xywh.w;
        var by = ay;
        var cx = bx;
        var cy = ay + xywh.h;
        var dx = ax;
        var dy = cx;
        pen.pos = start;
        #if target.static
        lastXY = { x: tri.x, y: tri.y };
        #else
        if( tri.x != null && tri.y != null ) lastXY = { x: tri.x, y: tri.y };
        #end
        // rebuild does this work!!?
        tri.curr.triangle( ax, ay, tri.curr.z, bx, by, tri.curr.z, dx, dy, tri.curr.z );
        pen.pos = start + 1;
        tri.curr.triangle( bx, by, tri.curr.z, cx, cy, tri.curr.z, dx, dy, tri.curr.z );
    }
    public function setWH( wh: { w: Float, h: Float } ){
        var xywh = { x: tri.x, y: tri.y, w: wh.w, h: wh.h };
        setXYWH( xywh );
    }
    public function updatePos(){
        pen.pos = start + 2;
    }
}