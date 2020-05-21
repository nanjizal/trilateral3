package trilateral3;

@:structInit
class IndexRange{
    public var start: Int;
    public var end:   Int;
    public function new( start: Int, end: Int ){
        this.start = start;
        this.end   = end;
    }
    public static inline 
    function merge( ir0: IndexRange, ir1: IndexRange ): IndexRange {
        return { start: ir0.start, end: ir1.end };
    }
}
