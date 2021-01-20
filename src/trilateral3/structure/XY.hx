package trilateral3.structure;
/** 
   { x, y }
**/
@:structInit
class XY {
    public var x = 0.; 
    public var y = 0.;
    @:optional public var w = 1.;
    public function new( x: Float, y: Float ){
        this.x = x; 
        this.y = y;
    }
    public function clone(): XY {
        return { x: x, y: y };
    }
}