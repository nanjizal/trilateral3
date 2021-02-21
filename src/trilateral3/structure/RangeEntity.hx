package trilateral3.structure;
import trilateral3.shape.IteratorRange;
@:structInit
class RangeEntity{
    public var textured: Bool;
    public var range: IteratorRange;
    public var bgColor: Int = 0xFFFFFFFF;
    public function new( textured: Bool, range: IteratorRange, ?bgColor: Int = 0xFFFFFFFF ){
        this.textured = textured;
        this.range    = range;
        this.bgColor  = bgColor;
    }
    public function clone(): RangeEntity {
        return { textured: this.textured, range: this.range, bgColor: this.bgColor };
    }
}