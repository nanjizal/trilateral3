package trilateral2;
@:structInit
class RegularShape{
    public var x: Float;
    public var y: Float;
    public var radius: Float;
    public var color: Int;
    public function new( x: Float, y: Float, radius: Float, color: Int ){
        this.x      = x;
        this.y      = y;
        this.radius = radius;
        this.color  = color;
    }
    public function clone(): RegularShape {
        return { x: this.x, y: this.y, radius: this.radius, color: this.color };
    }
}