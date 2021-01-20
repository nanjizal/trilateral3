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
    public function new( pen: Pen, iteratorRange: IteratorRange, wid: Float = 1000, hi: Float = 1000 ){
        this.pen        = pen;
        this.range = iteratorRange;
        tri  = new TrianglesShaper( pen, wid, hi );
        for( i in range ){
            pen.pos  = i;
            if( tri.x < px ) px = tri.x;
            if( tri.y < py ) py = tri.y;
            if( tri.u < pu ) pu = tri.u;
            if( tri.v < pv ) pv = tri.v;
        }
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
    public function setColor( col: Int ){
        for( i in range ){
            pen.pos = i;
            tri.argb = col;
        }
    }
    public function setXY( xy: XY ){
        var dx = px - xy.x;
        var dy = py - xy.y;
        for( i in range ){
            pen.pos = i;
            tri.x = tri.x + dx;
            tri.y = tri.y + dy;
        }
        px = xy.x;
        py = xy.y;
    }
    public function setUV( xy: XY ){
        var du = pu - xy.x;
        var dv = pv - xy.y;
        for( i in range ){
            pen.pos = i;
            tri.u = tri.u + du;
            tri.v = tri.v + dv;
        }
        pu = xy.x;
        pv = xy.y;
    }
    // untested.
    public function rotateAbout( ax: Float, ay: Float, val: Float ){
        for( i in range ){
            pen.pos = i;
            tri.rotateCentre2( tri.x, tri.y, ax, ay, val );
        }
    }
}