package trilateral3.reShape;
import trilateral3.drawing.Pen;
import trilateral3.reShape.TrianglesShaper;
import trilateral3.structure.XY;
import trilateral3.structure.XY0;
import trilateral3.structure.XYWH;
import trilateral3.structure.WH;
import trilateral3.matrix.Vertex;
import trilateral3.structure.Triangle3D;
class QuadShaper {
    var tri: TrianglesShaper;
    var pen:         Pen;
    public var lastXY: XY;
    public var lastUV: XY;
    var oldStart:    Float;
    var start:       Float;
    // TODO: startU, startV need more thought, used for setting up offset rotation.
    public var startU: Float;
    public var startV: Float;
    public var width: Float;
    public var height: Float;
    public var name:        String;
    public function new( pen: Pen, start: Float = -1., wid: Float = 1000, hi: Float = 1000 ){
        if( start == -1 ) start = pen.pos;
        this.pen        = pen;
        this.start      = start;
        tri  = new TrianglesShaper( pen, wid, hi );
    }
    public function drawQuadStart( u: Float, v: Float, w: Float, h: Float ): Int {
        var p = pen.pos;
        pen.pos    = start;
        width = w;
        height = h;
        startU = u;
        startV = v;
        var q = pen.quad2DFill( u, v, w, h );
        return q;
    }
    public function drawQuad( u: Float, v: Float, w: Float, h: Float ): Int {
        width = w;
        height = h;
        startU = u;
        startV = v;
        var q = pen.quad2DFill( u, v, w, h );
        return q;
    }
    public function dim( dx: Float, dy: Float ){
        //
        //   A          C
        //               
        //   B          .
        // 
        var p = pen.pos;
        pen.pos    = start;
        var o = tri.fromGLTriangle( tri.tri3D() );
        var origX = o.a.x;
        var origY = o.a.y;
        var by = origY + dy;
        var cx = origX + dx;
        pen.posTriangle2D( origX, o.a.y, o.b.x, by, cx, o.c.y );
        //              A
        //               
        //   B          C
        //
        
        pen.pos    = start + 1;
        var o = tri.fromGLTriangle( tri.tri3D() );
        var ax = origX + dx;
        var cx = origX + dx;
        var by = origY + dy;
        var cy = origY + dy;
        pen.posTriangle2D( ax, o.a.y, o.b.x, by, cx, cy );
        
        pen.pos = p;
    }
    /*
    // a  b
    // d  c
    // used to adjust corners of current triangle, mostly as example for future extensions.
    public function dCorners( a: Vertex, b: Vertex, c: Vertex, d: Vertex ){
        //
        //   A          C
        //               
        //   B          .
        // 
        var p = pen.pos;
        pen.pos    = start;
        var o = tri.fromGLTriangle( tri.tri3D() );
        o.a.x += a.x;
        o.a.y += a.y;
        o.b.x += d.x;
        o.b.y += d.y;
        o.c.x += b.x;
        o.c.y += b.y;
        pen.posTriangle2D( o.a.x, o.a.y
                         , o.b.x, o.b.y
                         , o.c.x, o.c.y );
        //
        //              A
        //               
        //   B          C
        //
        pen.pos    = start + 1;
        var o = tri.fromGLTriangle( tri.tri3D() );
        o.a.x += b.x;
        o.a.y += b.y;
        o.b.x += d.x;
        o.b.y += d.y;
        o.c.x += c.x;
        o.c.y += c.y;
        pen.posTriangle2D( o.a.x, o.a.y
                         , o.b.x, o.b.y
                         , o.c.x, o.c.y );
        pen.pos = p;
    }
    */
    public function rook_90(){
        rotateLockTopLeft( -Math.PI/2 );
    }
    public function rook90(){
        rotateLockTopLeft( Math.PI/2 );
    }
    // only use from 0 to Math.PI/2;
    public function rotateLockTopLeft( theta: Float ){
        if( theta > Math.PI/2 || theta < -Math.PI/2 ){
            // may need more consideration
            throw new haxe.Exception( 'theta needs to be between 0 and pi/2' );
        }
        var p = pen.pos;
        pen.pos    = start;
        tri.curr = pen.triangleCurrent;
        var curr   = tri.curr;
        var ax = tri.x;
        var ay = tri.y;
        //var az = tri.z;
        var w      = tri.right   - ax;
        var h      = tri.bottom  - ay;
        tri.rotateCentre( ax + w/2, ay + h/2, theta );
        pen.pos = start + 1;
        tri.rotateCentre( ax + w/2, ay + h/2, theta );
        pen.pos = start;
        var nx = tri.x;
        var ny = tri.y;
        tri.x = ax;
        tri.y = ay;
        var dx = ax - nx;
        var dy = ay - ny;
        pen.pos = start + 1;
        tri.x = tri.x + dx;
        tri.y = tri.y + dy;
        pen.pos = p;
    }
    public function rotateFromCentre( dx: Float, dy: Float, theta: Float ){
        var p = pen.pos;
        pen.pos    = start;
        var curr   = tri.curr;
        var ax = tri.x;
        var ay = tri.y;
        tri.rotateCentre( startU + dx, startV + dy, theta );
        pen.pos = start + 1;
        tri.rotateCentre( startU + dx, startV + dy, theta );
        pen.pos = p;
    }
    public function getDeltaAX( ax: Float, ay: Float ): {x: Float, y: Float }{
        var p = pen.pos;
        pen.pos = start;
        var nx = tri.x;
        var ny = tri.y;
        tri.x = ax;
        tri.y = ay;
        var dx = ax - nx;
        var dy = ay - ny;
        pen.pos = p;
        var deltaAX = { x: dx, y: dy };
        return deltaAX;
    }
    public function drawQuadColors(  u: Float, v: Float, w: Float, h: Float
                                   , colorA: Int = -1, colorB: Int = -1
                                   , colorC: Int = -1, colorD: Int = -1 ): Int {
        return pen.quad2DFillColors( u, v, w, h, colorA, colorB, colorC, colorD );
    }
    public function modifyQuadColors( colorA: Int = -1, colorB: Int = -1
                                    , colorC: Int = -1, colorD: Int = -1 ) {
        this.pen.pos = start;
        this.pen.paintType.cornerColors( colorA, colorD, colorB );
        this.pen.pos = start+1;
        this.pen.paintType.cornerColors( colorB, colorD, colorC );
    }
    public var begin( get, set ): Int;
    inline
    function get_begin(): Int {
        return Std.int( start );
    }
    inline
    function set_begin( val: Int ){
        oldStart = start;
        start = cast val;
        return cast start;
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
    public var x( get, set ): Float;
    inline function get_x(): Float {
        var _xy = xy;
        return _xy.x;
    }
    inline function set_x( v: Float ): Float {
        var _xy = xy;
        xy = { x: v, y: xy.y };
        return v;
    }
    public var y( get, set ): Float;
    inline function get_y(): Float {
        var _xy = xy;
        return _xy.y;
    }
    inline function set_y( v: Float ): Float {
        var _xy = xy;
        xy = { x: xy.x, y: v };
        return v;
    }
    public var xy( get, set ): XY;
    inline function get_xy(): XY {
        pen.pos = start;
        return tri.xy;
    }
    inline function set_xy( val: XY ): XY {
        var p = pen.pos;
        pen.pos = start;
        #if target.static
        lastXY = { x: tri.x, y: tri.y };
        #else
        if( tri.x != null && tri.y != null ) lastXY = { x: tri.x, y: tri.y };
        #end
        tri.xy = val;
        pen.pos = start+1;
        tri.xy = val;
        pen.pos = p;
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
    /*
    use drawQuad... potentially this is redunant, keep for now.
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
    */
    public function updatePos(){
        pen.pos = start + 2;
    }
}