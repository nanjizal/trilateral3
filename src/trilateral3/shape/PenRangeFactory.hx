package trilateral3.shape;
import trilateral3.drawing.Pen;
import trilateral3.shape.IteratorRange;

class PenRangeFactory {
    public var pen: Pen;
    public var posMin: Int;
    public var lastPos: Int;
    public inline
    function new( pen: Pen ){
        this.pen = pen;
        posMin = Std.int( pen.pos );
        lastPos = posMin;
    }
    public inline
    function resetTo( p: Float ){
        posMin = Std.int( pen.pos );
        this.pen.pos = p;
        lastPos = posMin;
    }
    public inline
    function start(): Int{
        posMin = Std.int( pen.pos );
        return posMin;
    }
    public inline
    function current(): Int{
        return Std.int( pen.pos );
    }
    public inline
    function end(): IteratorRange {
        return posMin...Std.int( pen.pos );
    }
    public inline
    function difEnd(): IteratorRange {
        var lastPosNext = Std.int( pen.pos );
        var out: IteratorRange = lastPos...lastPosNext;
        lastPos = lastPosNext;
        return out;
    }
}