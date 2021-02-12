package trilateral3.reShape;
import trilateral3.drawing.Pen;
import trilateral3.structure.XY;
import trilateral3.structure.XYWH;
import trilateral3.structure.WH;
// 1 2 3
// 4 5 6
// 7 8 9

// needs testing
class NineShaper {
    var tri: TrianglesShaper;
    var pen:         Pen;
    var start:       Int;
    var right:       Float;
    var left:        Float;
    var top:         Float;
    var bottom:      Float;
    var quadShaper:  QuadShaper;
    // assumes setup with same borders?
    public function new( pen: Pen, start: Int, wid: Float = 1000, hi: Float = 1000 ){
        this.pen        = pen;
        this.start      = start;
        tri  = new TrianglesShaper( pen, wid, hi );
        // 1
        pen.pos = start;
        left = tri.right - tri.x;
        top = tri.bottom - tri.y;
        // 9 = 16 ( 9-1 ) * 2;
        pen.pos = start + 16;
        right = tri.right - tri.x;
        bottom = tri.bottom - tri.y;
    }
    public inline 
    function XYWH( xywh: { x: Float, y: Float, w: Float, h: Float } ){
        var middleW = xywh.w - right - left;
        var middleH = xywh.h - top - bottom;
        var q = new QuadShaper( pen, start );
        // 1 don't change width.
        q.xy = { x: xywh.x, y: xywh.y };
        // ax bx cx
        var ax = xywh.x;
        var bx = ax + left;
        var cx = ax + xywh.w - right;
        // ay
        // by
        // cy
        var ay = xywh.y;
        var by = ay + top;
        var cy = ay + xywh.h - bottom;
        // 2 
        q.begin = start + 2;
        q.setXYWH( { x: bx, y: ay, w: middleW, h: top } );
        // 3
        q.begin = start + 4;
        q.xy = { x: cx, y: ay };
        //____
        // 4 ( next row)
        q.begin = start + 6;
        q.setXYWH( { x: ax, y: by, w: left, h: middleH } );
        // 5
        q.begin = start + 8;
        q.setXYWH( { x: bx, y: by, w: middleW, h: middleH } );
        // 6
        q.begin = start + 10;
        q.setXYWH( { x: cx, y: by, w: right, h: middleH } );
        //____
        // 7 
        q.begin = start + 12;
        q.xy = { x: ax, y: cy };
        // 8
        q.begin = start + 14;
        q.setXYWH( { x: bx, y: cy, w: middleW, h: bottom } );
        // 9 
        q.begin = start + 12;
        q.xy = { x: cx, y: cy };
    }
}