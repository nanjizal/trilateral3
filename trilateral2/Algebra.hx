package trilateral2;
import geom.matrix.Matrix1x2;
import geom.obj.Quad2D;
import geom.curve.Bezier;

class Algebra {
    // A B C, you can find the winding by computing the cross product (B - A) x (C - A)
    public static inline
    function adjustWinding( A_: Matrix1x2, B_: Matrix1x2, C_: Matrix1x2 ): Bool{
        var ba = B_ - A_;
        var ca = C_ - A_;
        var val: Bool = !( ba.perp( ca ) < 0 );
        return val;
    }
    public static inline
    function sign( n: Float ): Int {
        return Std.int( Math.abs( n )/n );
    }
    public static
    var quadStep: Float = 0.03;
    // Create Quadratic Curve
    public static inline
    function quadCurve( p: Array<Float>, ax: Float, ay: Float, bx: Float, by: Float, cx: Float, cy: Float ): Array<Float> {
        var step = calculateQuadStep( ax, ay, bx, by, cx, cy );
        var l = p.length;
        p[ l++ ] = ax;
        p[ l++ ] = ay;
        var t = step;
        while( t < 1. ){
            p[ l++ ] = Bezier.quadratic( t, ax, bx, cx );
            p[ l++ ] = Bezier.quadratic( t, ay, by, cy );
            t += step;
        }
        p[ l++ ] =  cx;
        p[ l++ ] =  cy;
        return p;
    }
    public static
    var cubicStep: Float = 0.03;
    // Create Cubic Curve
    public static inline 
    function cubicCurve( p: Array<Float>, ax: Float, ay: Float, bx: Float, by: Float, cx: Float, cy: Float, dx: Float, dy: Float ): Array<Float> {
        var step = calculateCubicStep( ax, ay, bx, by, cx, cy, dx, dy );
        var l = p.length;
        p[ l++ ] = ax;
        p[ l++ ] = ay;
        var t = step;
        while( t < 1. ){
            p[ l++ ] = Bezier.cubic( t, ax, bx, cx, dx );
            p[ l++ ] = Bezier.cubic( t, ay, by, cy, dy );
            t += step;
        }
        p[ l++ ] =  dx;
        p[ l++ ] =  dy;
        return p;
    }
    public static inline
    function calculateQuadStep( ax: Float, ay: Float, bx: Float, by: Float, cx: Float, cy: Float ): Float {
        var approxDistance = distance( ax, ay, bx, by ) + distance( bx, by, cx, cy );
        if( approxDistance == 0 ) approxDistance = 0.000001;
        return Math.min( 1/( approxDistance*0.707 ), quadStep );
    }
    public static inline
    function calculateCubicStep( ax: Float, ay: Float, bx: Float, by: Float, cx: Float, cy: Float, dx: Float, dy: Float ): Float {
        var approxDistance = distance( ax, ay, bx, by ) + distance( bx, by, cx, cy ) + distance( cx, cy, dx, dy );
        if( approxDistance == 0 ) approxDistance = 0.000001;
        return Math.min( 1/( approxDistance*0.707 ), cubicStep );
    }
    // may not be most optimal
    public inline static
    function lineAB( A: Matrix1x2, B: Matrix1x2, width: Float ): Quad2D {
        var dx: Float = A.x - B.x;
        var dy: Float = A.y - B.y;
        var P: Matrix1x2 = { x:A.x - width/2, y:A.y };
        var omega = thetaCheap( dx, dy ); // may need angle correction.
        var dim: Matrix1x2 = { x: width, y: distCheap( dx, dy ) };
        return rotateVectorLine( P, dim, omega, A.x + width/2, A.y );
    }
    // may not be most optimal
    public inline static
    function lineABCoord( ax: Float, ay: Float, bx: Float, by: Float, width: Float ):Quad2D{
        var dx: Float = ax - bx;
        var dy: Float = ay - by;
        var P: Matrix1x2 = { x:ax - width/2, y:ay };
        var omega = thetaCheap( dx, dy ); // may need angle correction.
        var dim: Matrix1x2 = { x: width, y: distCheap( dx, dy ) };
        return rotateVectorLine( P, dim, omega, ax + width/2, ay );
    }
    public inline static
    function rotateVectorLine( pos: Matrix1x2, dim: Matrix1x2, omega: Float, pivotX: Float, pivotY: Float ): Quad2D {
        //   A   B
        //   D   C
        var px = pos.x;
        var py = pos.y;
        var dx = dim.x;
        var dy = dim.y;
        var A_: Matrix1x2 = { x: px,            y: py };
        var B_: Matrix1x2 = { x: px + dx,   y: py };
        var C_: Matrix1x2 = { x: px + dx,   y: py + dy };
        var D_: Matrix1x2 = { x: px,            y: py + dy };
        if( omega != 0. ){
            var sin = Math.sin( omega );
            var cos = Math.cos( omega );
            A_ = Algebra.pivotCheap( A_, sin, cos, pivotX, pivotY );
            B_ = Algebra.pivotCheap( B_, sin, cos, pivotX, pivotY );
            C_ = Algebra.pivotCheap( C_, sin, cos, pivotX, pivotY );
            D_ = Algebra.pivotCheap( D_, sin, cos, pivotX, pivotY );
        }
        return { A:A_, B:B_, C:C_, D:D_ };
    }
    public inline static
    function pivotCheap( p: Matrix1x2, sin: Float, cos: Float, pivotX: Float, pivotY: Float ): Matrix1x2 {
        var px = p.x - pivotX;
        var py = p.y - pivotY;
        var px2 = px * cos - py * sin;
        py = py * cos + px * sin;
        return { x: px2 + pivotX, y: py + pivotY };
    }
    public inline static // not used?
    function pivot( p: Matrix1x2, omega: Float, pivotX: Float, pivotY: Float ): Matrix1x2 {
        var px = p.x - pivotX;
        var py = p.y - pivotY;
        var px2 = px * Math.cos( omega ) - py * Math.sin( omega );
        py = py * Math.cos( omega ) + px * Math.sin( omega );
        return { x: px2 + pivotX, y: py + pivotY };
    }
    public inline static
    function thetaCheap( dx: Float, dy: Float ): Float {
        return Math.atan2( dy, dx );
    }
    public static inline
    function distCheap( dx: Float, dy: Float  ): Float {
        return dx*dx + dy*dy;
    }
    public static inline
    function distance(  px: Float, py: Float, qx: Float, qy: Float ): Float {
        var x = px - qx;
        var y = py - qy;
        return Math.sqrt( x*x + y*y );
    }
}
