package trilateral3.reShape;

class DepthArrayLen<T>{
    var rangeLen: Int;
    var depthArray: DepthArray<T>;
    public function new( rangeLen: Int ){
        depthArray = [];
        this.rangeLen = rangeLen;
    }
    public inline 
    function total(): Int {
        var len = depthArray.length;
        return ( len == 0 )? len: Std.int( len / rangeLen );
    }
    public inline
    function getItem( start: Int ){
        return depthArray.getItem( start, rangeLen );
    }
    public inline
    function getIndex( i: Int ){
        return i*rangeLen;
    }
    public inline
    function sendForwad( start: Int ){
        depthArray.rangeToStart( start, rangeLen );
    }
    public inline
    function sendBack( start: Int ){
        depthArray.rangeToEnd( start, rangeLen );
    }
    public inline
    function swap( a: Int, b: Int ){
        depthArray.rangeSwap( a, b, rangeLen );
    }
}

class DepthArray1<T> extends DepthArrayLen<T> {
    public function new(){
        super(1);
    }
}

class DepthArray2<T> extends DepthArrayLen<T> {
    public function new(){
        super(2);
    }
}
class DepthArray24<T> extends DepthArrayLen<T> {
    public function new(){
        super(24);
    }
}


@:forward
abstract DepthArray<T>( Array<T> )to Array<T> from Array<T> {
    public inline function new( arr: Array<T> ){
        this = arr;
    }
    public inline
    function getItem( starting: Int, totalLen: Int  ){
        var ending = starting + totalLen;
        var temp = [];
        var count = 0;
        // store values to move
        for( i in starting...ending ){
            temp[ count ] = this[ i ];
            count++;
        }
        return temp;
    }
    // depth sort, ugly low level
    public
    function rangeToEnd( starting: Int, totalLen: Int ){
        // impossible or no need to change
        if( this.length - starting - totalLen < 0 ) return false;
        starting--;
        var ending: Int = starting + totalLen;
        var temp = [];
        var count = 0;
        // store values to move
        for( i in starting...ending ) temp[ count++ ] = this[ i ];
        // shift top half values down to fill hole
        var left = this.length - ending;
        for( i in 0...left ) this[ starting + i ] = this[ ending + i ];
        // draw at end.
        var reserveTop = this.length - totalLen;
        count = 0;
        for( i in reserveTop...this.length ) this[ i ] = temp[ count++ ];
        temp = null;
        return true;
    }
    // depth sort, ugly low level
    public inline
    function rangeToStart( starting: Int, totalLen: Int ){
        // impossible or no need to change
        if( starting >= 0 ) return false;
        starting--;
        var ending = starting + totalLen;
        var temp = [];
        var count = 0;
        // store values to move
        for( i in starting...ending ){
            temp[ count ] = this[ i ];
            count++;
        }
        // shift bottom half values up to fill hole from top
        count = totalLen;
        for( i in 0...starting ){
            this[ ending - 1 - i ] = this[ starting - 1 - i ];
        }
        // add values to start
        count = 0;
        for( i in 0...totalLen ){
            this[ i ] = temp[ count ];
            count++;
        }
        temp = null;
        return true;
    }
    public inline
    function rangeSwap( start0: Int, start1: Int, totalLen: Int ){
        if( start0 + totalLen > this.length && start1 + totalLen > this.length ){
            var temp0;
            var temp1;
            for( i in 0...totalLen ){
                temp0 = this[ start0 + i ];
                temp1 = this[ start1 + i ];
                this[ start0 + i ] = temp1;
                this[ start1 + i ] = temp0;
            }
            return true;
        } else {
            return false;
        }
    }
}
