package trilateral3.structure;
/** 
   { x, y, ?w }
 */
@:structInit
class XY0 {
    public var x = 0; 
    public var y = 0;
    @:optional public var w = 1;
    public function new( x: Int, y: Int ){
        this.x = x; 
        this.y = y;
    }
    public function clone(): XY0 {
        return { x: x, y: y };
    }
}