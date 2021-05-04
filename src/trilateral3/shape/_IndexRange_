package trilateral3.shape;
import trilateral3.structure.StartEnd;
@:forward
abstract IndexRange( StartEnd ) from StartEnd to StartEnd {
    public function new( startEnd: StartEnd ){ this = startEnd; }
    @:op(A + B) public static inline
    function adding( a: IndexRange, b: IndexRange ): IndexRange {
      	return a.add( b );
    }
    public inline
    function add( b: StartEnd ): IndexRange {
        var begin: Int = Std.int( Math.min( this.start, b.start ) );
        return new IndexRange( {  start: begin
                                , end: ( begin == this.start )? b.end: this.end } );
    }
    public
    var length( get, never ): Int; 
    inline
    function get_length(): Int {
        return this.end - this.start + 1;
    }
    inline
    public function contains( v: Int ): Bool {
        return ( v > ( this.start - 1 ) && ( v < this.end + 1 ) );
    }
    inline
    public function isWithin( ir: IndexRange ): Bool {
        return contains( ir.start ) && contains( ir.end );
    }
    inline
    public function moveRange( v: Int ){
        this.start += v;
        this.end   += v;
    }
    inline
    public function ifContainMove( v: Int, amount: Int ): Bool {
        var ifHas = contains( v );
        if( ifHas ) moveRange( amount );
        return ifHas; 
    }
}
