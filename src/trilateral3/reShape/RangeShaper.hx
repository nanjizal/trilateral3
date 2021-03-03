package trilateral3.reShape;
import trilateral3.drawing.Pen;
import trilateral3.reShape.TrianglesShaper;
import trilateral3.structure.XY;
import trilateral3.structure.XYWH;
import trilateral3.structure.WH;
import trilateral3.shape.IteratorRange;

class RangeShaper {
    var tri: TrianglesShaper;
    var pen:         Pen;
    public var range:  IteratorRange;
    var px = 10000000000;
    var py = 10000000000;
    var pu = 10000000000;
    var pv = 10000000000;
    
    public var lastXY: XY;
    public var lastUV: XY;
    var oldStart:    Int;
    var start:       Int;
    public var name:        String;
    
    public function new( pen: Pen, iteratorRange: IteratorRange, wid: Float = 1000, hi: Float = 1000 ){
        this.pen        = pen;
        this.range      = iteratorRange;
        this.start      = iteratorRange.start;
        tri  = new TrianglesShaper( pen, wid, hi );
        for( i in range ){
            pen.pos  = i;
            if( tri.x < px ) px = tri.x;
            if( tri.y < py ) py = tri.y;
            if( tri.currUV != null ){
                if( tri.u < pu ) pu = tri.u;
                if( tri.v < pv ) pv = tri.v;
            }
        }
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
        range.moveRange( start - oldStart );
        return start;
    }
    
    public
    function fullHit( x: Float, y: Float ): Array<Int> {
        var hitArray = new Array<Int>();
        var count = 0;
        var hit: Bool = false;
        for( t in range ){
            pen.pos = t;
            hit = tri.fullHit( x, y );
            if( hit ) hitArray[ hitArray.length ] = count;
            count++;
        }
        return hitArray;
    }
    public var visible( never, set ): Bool;
    inline
    function set_visible( val: Bool ): Bool {
        if( val ){
            for( i in range ){
                pen.pos = i;
                tri.show();
            }
        } else {
            for( i in range ){
                pen.pos = i;
                tri.hide();
            }
        }
        return val;
    }
    public var alpha( never, set ): Float;
    inline
    function set_alpha( val: Float ){
        for( i in range ){
            pen.pos = i;
            tri.alpha = val;
        }
        return val;
    }
    public var argb( never, set ): Int;
    inline 
    function set_argb( col: Int ): Int {
        for( i in range ){
            pen.pos = i;
            tri.argb = col;
        }
        return col;
    }
    public function setColor( col: Int ){
        for( i in range ){
            pen.pos = i;
            tri.argb = col;
        }
    }
    public var xy( get, set ): XY;
    inline function get_xy(): XY {
        return { x: px, y: py };
    }
    inline function set_xy( xy: XY ){
        lastXY = { x: px, y: py };
        var dx = px - xy.x;
        var dy = py - xy.y;
        for( i in range ){
            pen.pos = i;
            tri.x = tri.x + dx;
            tri.y = tri.y + dy;
        }
        px = xy.x;
        py = xy.y;
        return xy;
    }
    public var uv( get, set ): XY;
    inline function get_uv(): XY {
        return { x: pu, y: pv };
    }
    inline function set_uv( xy: XY ){
        lastUV = { x: pu, y: pv };
        var du = pu - xy.x;
        var dv = pv - xy.y;
        for( i in range ){
            pen.pos = i;
            tri.u = tri.u + du;
            tri.v = tri.v + dv;
        }
        pu = xy.x;
        pv = xy.y;
        return xy;
    }
    // untested.
    public function rotateAbout( ax: Float, ay: Float, val: Float ){
        for( i in range ){
            pen.pos = i;
            tri.rotateCentre2( tri.x, tri.y, ax, ay, val );
        }
    }
}