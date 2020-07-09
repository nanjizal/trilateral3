package trilateral3.structure;
import trilateral3.structure.WH;
/** 
   { x, y, w, h }
**/
@:structInit
class XYWH_ extends WH_ {
    public var x: Int = 0;
    public var y: Int = 0;
    public function new( x: Int, y: Int, w: Int, h: Int ){
        super( w, h );
        this.x = x;
        this.y = y;
    }
}

@:forward
abstract XYWH( XYWH_ ) from XYWH_ to XYWH_ {
    public inline
    function new( xywh: XYWH_ ){
        this = xywh;
    }
    public inline
    function r(){
        return this.x + this.w;
    }
    public inline
    function b(){
        return this.y + this.h;
    }
    public inline
    function setR( rr: Int ){
       this.w = (rr - this.x);
    }
    public inline
    function setB( bb: Int ){
       this.h = (bb - this.y);
    }
    inline
    function mother(): WH {
        var wh: WH = { w: this.w, h: this.h };
        return wh;
    }
    public inline
    function area():Int {
        return mother().area();
    }
    public inline
    function perimeter(): Int{
        return mother().perimeter();
    }
    public inline
    function fits( r: WH ): Int {
        return mother().fits( r );
    }
}  