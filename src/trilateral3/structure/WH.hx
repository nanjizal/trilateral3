package trilateral3.structure;
/** 
   { w, h }
**/
@:structInit
class WH_ {
    public var w: Int = 0; 
    public var h: Int = 0;
    public function new( w: Int, h: Int ){
        this.w = w; 
        this.h = h;
    }
}

@:forward
abstract WH( WH_ ) from WH_ to WH_ {
    public inline
    function new( wh: WH_ ){
        this = wh;
    }
    public inline
    function area():Int {
        return Std.int( this.w*this.h );
    }
    public inline
    function perimeter(): Int {
        return Std.int( 2*this.w + 2*this.h );
    }
    public inline
    function fits( r: WH ): Int {
        return if( this.w == r.w && this.h == r.h ) {
            3;
        } else if( this.h == r.w && this.w == r.h ) {
            4;
        } else if( this.w <= r.w && this.h <= r.h ) {
            1;
        } else if( this.h <= r.w && this.w <= r.h ) {
            2;
        } else {
            0;
        }
    }
}