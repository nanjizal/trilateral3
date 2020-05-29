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
        var begin: Int = cast Math.min( this.start, b.start );
        return new IndexRange( {  start: begin
                                , end: ( begin == this.start )? b.end: this.end } );
    }
}
