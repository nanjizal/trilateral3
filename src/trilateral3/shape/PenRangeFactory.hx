package trilateral3.shape;
import trilateral3.drawing.Pen;
import trilateral3.shape.IteratorRange;

class PenRangeFactory {
    public var pen: Pen;
    public var posMin: Int;
    public inline
    function new( pen: Pen ){
        this.pen = pen;
        posMin = Std.int( pen.pos );
    }
    public inline
    function start(): Int{
        posMin = Std.int( pen.pos );
        return posMin;
    }
    public inline
    function end(): IteratorRange {
        return posMin...Std.int( pen.pos );
    }
}