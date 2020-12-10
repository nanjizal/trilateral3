package trilateral3.reShape;
import trilateral3.drawing.Pen;
import trilateral3.reShape.TrianglesShaper;
import trilateral3.structure.XY;
import trilateral3.structure.XYWH;
import trilateral3.structure.WH;

class QuadShaper {
    var tri: TrianglesShaper;
    var pen:         Pen;
    public var start:       Int;
    public function new( pen: Pen, start: Int ){
        this.pen        = pen;
        this.start      = start;
        tri  = new TrianglesShaper( pen );
    }
    public function setColor( col: Int ){
        pen.pos = start;
        tri.argb = col;
        pen.pos = start + 1;
        tri.argb = col; 
    }
    public function setXY( xy: XY ){
        pen.pos = start;
        tri.x = xy.x;
        tri.y = xy.y;
        pen.pos = start + 1;
        tri.x = xy.x;
        tri.y = xy.y;
    }
    public function setUV( xy: XY ){
        pen.pos = start;
        tri.u = xy.x;
        tri.v = xy.y;
        pen.pos = start + 1;
        tri.u = xy.x;
        tri.v = xy.y;
    }
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
        // rebuild does this work!!?
        tri.curr.triangle( ax, ay, tri.curr.z, bx, by, tri.curr.z, dx, dy, tri.curr.z );
        pen.pos = start + 1;
        tri.curr.triangle( bx, by, tri.curr.z, cx, cy, tri.curr.z, dx, dy, tri.curr.z );
    }
    public function setWH( wh: { w: Float, h: Float } ){
        pen.pos = start;
        var xywh = { x: tri.x, y: tri.y, w: wh.w, h: wh.h };
        setXYWH( xywh );
    }
}