package trilateral3.math;
import trilateral3.structure.XY;
import trilateral3.structure.Quad2D;

// A B C, you can find the winding by computing the cross product (B - A) x (C - A)
inline
function adjustWinding( A_: XY, B_: XY, C_: XY ): Bool{
    var ba = minusXY( B_, A_);
    var ca = minusXY( C_, A_);
    var val: Bool = !( perp( ba, ca ) < 0 );
    return val;
}
inline 
function minusXY( a: XY, b: XY ){
    var xy: XY = { x: a.x - b.x, y: a.y - b.y };
    return xy;
}
inline
function sign( n: Float ): Int {
    return Std.int( Math.abs( n )/n );
}
var quadStep: Float = 0.03;
// Create Quadratic Curve
inline
function quadCurve( p: Array<Float>, ax: Float, ay: Float, bx: Float, by: Float, cx: Float, cy: Float ): Array<Float> {
    var step = calculateQuadStep( ax, ay, bx, by, cx, cy );
    var l = p.length;
    p[ l++ ] = ax;
    p[ l++ ] = ay;
    var t = step;
    while( t < 1. ){
        p[ l++ ] = quadratic( t, ax, bx, cx );
        p[ l++ ] = quadratic( t, ay, by, cy );
        t += step;
    }
    p[ l++ ] =  cx;
    p[ l++ ] =  cy;
    return p;
}
inline
var cubicStep: Float = 0.03;
// Create Cubic Curve
inline
function cubicCurve( p: Array<Float>, ax: Float, ay: Float, bx: Float, by: Float, cx: Float, cy: Float, dx: Float, dy: Float ): Array<Float> {
    var step = calculateCubicStep( ax, ay, bx, by, cx, cy, dx, dy );
    var l = p.length;
    p[ l++ ] = ax;
    p[ l++ ] = ay;
    var t = step;
    while( t < 1. ){
        p[ l++ ] = cubic( t, ax, bx, cx, dx );
        p[ l++ ] = cubic( t, ay, by, cy, dy );
        t += step;
    }
    p[ l++ ] =  dx;
    p[ l++ ] =  dy;
    return p;
}
inline
function calculateQuadStep( ax: Float, ay: Float, bx: Float, by: Float, cx: Float, cy: Float ): Float {
    var approxDistance = distance( ax, ay, bx, by ) + distance( bx, by, cx, cy );
    if( approxDistance == 0 ) approxDistance = 0.000001;
    return Math.min( 1/( approxDistance*0.707 ), quadStep );
}
inline
function calculateCubicStep( ax: Float, ay: Float, bx: Float, by: Float, cx: Float, cy: Float, dx: Float, dy: Float ): Float {
    var approxDistance = distance( ax, ay, bx, by ) + distance( bx, by, cx, cy ) + distance( cx, cy, dx, dy );
    if( approxDistance == 0 ) approxDistance = 0.000001;
    return Math.min( 1/( approxDistance*0.707 ), cubicStep );
}
// may not be most optimal
inline
function lineAB( A: XY, B: XY, width: Float ): Quad2D {
    var dx: Float = A.x - B.x;
    var dy: Float = A.y - B.y;
    var P: XY = { x:A.x - width/2, y:A.y };
    var omega = thetaCheap( dx, dy ); // may need angle correction.
    var dim: XY = { x: width, y: distCheap( dx, dy ) };
    return rotateVectorLine( P, dim, omega, A.x + width/2, A.y );
}
// may not be most optimal
inline
function lineABCoord( ax: Float, ay: Float, bx: Float, by: Float, width: Float ):Quad2D {
    var dx: Float = ax - bx;
    var dy: Float = ay - by;
    var P: XY = { x:ax - width/2, y:ay };
    var omega = thetaCheap( dx, dy ); // may need angle correction.
    var dim: XY = { x: width, y: distCheap( dx, dy ) };
    return rotateVectorLine( P, dim, omega, ax + width/2, ay );
}
inline
function rotateVectorLine( pos: XY, dim: XY, omega: Float, pivotX: Float, pivotY: Float ): Quad2D {
    //   A   B
    //   D   C
    var px = pos.x;
    var py = pos.y;
    var dx = dim.x;
    var dy = dim.y;
    var A_: XY = { x: px,        y: py };
    var B_: XY = { x: px + dx,   y: py };
    var C_: XY = { x: px + dx,   y: py + dy };
    var D_: XY = { x: px,        y: py + dy };
    if( omega != 0. ){
        var sin = Math.sin( omega );
        var cos = Math.cos( omega );
        A_ = pivotCheap( A_, sin, cos, pivotX, pivotY );
        B_ = pivotCheap( B_, sin, cos, pivotX, pivotY );
        C_ = pivotCheap( C_, sin, cos, pivotX, pivotY );
        D_ = pivotCheap( D_, sin, cos, pivotX, pivotY );
    }
    return { a:A_, b:B_, c:C_, d:D_ };
}
inline
function pivotCheap( p: XY, sin: Float, cos: Float, pivotX: Float, pivotY: Float ): XY {
    var px = p.x - pivotX;
    var py = p.y - pivotY;
    var px2 = px * cos - py * sin;
    py = py * cos + px * sin;
    return { x: px2 + pivotX, y: py + pivotY };
}
inline // not used?
function pivot( p: XY, omega: Float, pivotX: Float, pivotY: Float ): XY {
    var px = p.x - pivotX;
    var py = p.y - pivotY;
    var px2 = px * Math.cos( omega ) - py * Math.sin( omega );
    py = py * Math.cos( omega ) + px * Math.sin( omega );
    return { x: px2 + pivotX, y: py + pivotY };
}
inline
function thetaCheap( dx: Float, dy: Float ): Float {
    return Math.atan2( dy, dx );
}
inline
function distCheap( dx: Float, dy: Float  ): Float {
    return dx*dx + dy*dy;
}
inline
function distance(  px: Float, py: Float, qx: Float, qy: Float ): Float {
    var x = px - qx;
    var y = py - qy;
    return Math.sqrt( x*x + y*y );
}
inline
function quadraticThru( t: Float, s: Float, c: Float, e: Float ): Float {
    c = 2*c - 0.5*( s + e );
    return quadratic( t, s, c, e );
}
inline
function quadratic( t: Float, s: Float, c: Float, e: Float ): Float {
    var u = 1 - t;
    return Math.pow( u, 2 )*s + 2*u*t*c + Math.pow( t, 2 )*e;
}
inline
function quadSegment( t0: Float, t1: Float, s: Float, c: Float, e: Float ): Float {
    var u = t1 - t0;
    return s + (c - s + t0 * (e - 2 * c + s)) * u;
}
inline
function cubic( t: Float, s: Float, c1: Float, c2: Float, e: Float ): Float {
    var u = 1 - t;
    return  Math.pow( u, 3 )*s + 3*Math.pow( u, 2 )*t*c1 + 3*u*Math.pow( t, 2 )*c2 + Math.pow( t, 3 )*e;
}
inline
function perp( a: XY, b: XY ): Float {
    return a.x * b.y - a.y * b.x;
}

class Algebra{
    public var adjustWinding_: ( A_: XY, B_: XY, C_: XY ) -> Bool = adjustWinding;
    public var minusXY_: ( a: XY, b: XY )->XY = minusXY;
    public var sign_: ( n: Float ) -> Int = sign;
    public var quadCurve_: ( p: Array<Float>
                           , ax: Float, ay: Float
                           , bx: Float, by: Float
                           , cx: Float, cy: Float ) -> Array<Float> = quadCurve;
    public var cubicCurve_:( p: Array<Float>
                           , ax: Float, ay: Float
                           , bx: Float, by: Float
                           , cx: Float, cy: Float
                           , dx: Float, dy: Float ) -> Array<Float> = cubicCurve;
    public var calculateQuadStep_: ( ax: Float, ay: Float
                                   , bx: Float, by: Float
                                   , cx: Float, cy: Float ) -> Float = calculateQuadStep;
    public var calculateCubicStep_:( ax: Float, ay: Float
                                   , bx: Float, by: Float
                                   , cx: Float, cy: Float
                                   , dx: Float, dy: Float ) -> Float = calculateCubicStep;
    public var lineAB_: ( A: XY, B: XY, width: Float ) -> Quad2D = lineAB;
    public var lineABCoord_: ( ax: Float, ay: Float
                             , bx: Float, by: Float, width: Float ) -> Quad2D = lineABCoord;
    public var rotateVectorLine_: ( pos: XY, dim: XY
                                  , omega: Float
                                  , pivotX: Float, pivotY: Float ) -> Quad2D = rotateVectorLine;
    public var pivotCheap_: ( p: XY, sin: Float, cos: Float, pivotX: Float, pivotY: Float ) -> XY = pivotCheap;
    public var pivot_: ( p: XY, omega: Float, pivotX: Float, pivotY: Float ) -> XY = pivot;
    public var thetaCheap_: ( dx: Float, dy: Float ) -> Float = thetaCheap;
    public var distCheap_: ( dx: Float, dy: Float  ) -> Float = distCheap;
    public var distance_: (  px: Float, py: Float, qx: Float, qy: Float ) -> Float = distance;
    public var quadraticThru_: ( t: Float, s: Float, c: Float, e: Float ) -> Float = quadraticThru;
    public var quadratic_: ( t: Float, s: Float, c: Float, e: Float ) -> Float = quadratic;
    public var quadSegment_: ( t0: Float, t1: Float, s: Float, c: Float, e: Float ) -> Float = quadSegment;
    public var cubic_: ( t: Float, s: Float, c1: Float, c2: Float, e: Float ) -> Float = cubic;
    public var perp_: ( a: XY, b: XY ) -> Float = perp;
}
