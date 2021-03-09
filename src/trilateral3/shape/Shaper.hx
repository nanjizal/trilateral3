package trilateral3.shape;
import trilateral3.drawing.PaintType;
import trilateral3.math.Algebra;
import trilateral3.shape.IndexRange;
import trilateral3.structure.Quad2D;
import trilateral3.structure.XY;
import trilateral3.Trilateral;
import fracs.Angles;
import trilateral3.shape.PolyEdge;



/**
Shaper provides static methods for drawing with triangles.
the methods return the number of triangles added.
**/
inline
function add2DTriangle( paintType: PaintType
                      , ax: Float, ay: Float
                      , bx: Float, by: Float
                      , cx: Float, cy: Float ): Int {
    // don't need to reorder corners and Trilateral can do that!
    paintType.triangle( ax, ay, 0, bx, by, 0, cx, cy, 0 );
    var m = Trilateral.transformMatrix;
    if( m != null ) paintType.transform( m );
    paintType.next();
    return 1;
}
inline
function add2DQuad( paintType: PaintType
                  , ax: Float, ay: Float
                  , bx: Float, by: Float
                  , cx: Float, cy: Float
                  , dx: Float, dy: Float ): Int {
    add2DTriangle( paintType, ax, ay, bx, by, dx, dy );
    add2DTriangle( paintType, bx, by, cx, cy, dx, dy );
    return 2;
}
inline 
function quad( paintType: PaintType, q: Quad2D ): Int {
    return add2DQuad( paintType,  q.a.x, q.a.y, q.b.x, q.b.y, q.c.x, q.c.y, q.d.x, q.d.y );
}
inline 
function lineAB( paintType: PaintType
               , A: XY, B: XY
               , width: Float ): Int {
    var q = trilateral3.math.Algebra.lineAB( A, B, width );
    return quad( paintType, q );
}
inline 
function lineXY( paintType: PaintType
               , ax: Float, ay: Float, bx: Float, by: Float
               , width: Float ): Int {
    var q = lineABCoord( ax, ay, bx, by, width );
    return quad( paintType, q );
}
inline
function rectangle( paintType: PaintType
    , x: Float, y: Float, w: Float, h: Float ): Int {
    var ax = x;
    var ay = y;
    var bx = x + w;
    var by = ay;
    var cx = bx;
    var cy = ay + h;
    var dx = x;
    var dy = cy; 
    return add2DQuad( paintType, ax, ay, bx, by, cx, cy, dx, dy );
}
//    a  b
//    d  c
inline
function squareOutline( paintType: PaintType
                      , px: Float, py: Float
                      , radius: Float, thick: Float, ?theta: Float = 0 ): Int {
    var ax = 0.;
    var ay = 0.;
    var bx = 0.;
    var by = 0.;
    var cx = 0.;
    var cy = 0.;
    var dx = 0.;
    var dy = 0.;
    var a0x = 0.;
    var a0y = 0.;
    var b0x = 0.;
    var b0y = 0.;
    var c0x = 0.;
    var c0y = 0.;
    var d0x = 0.;
    var d0y = 0.;
    if( theta != 0 ){
        var pi = Math.PI;
        var pi4 = pi/4;
        var pi2 = pi/2;
        var sqrt2 = Math.sqrt( 2 );
        var r = radius*sqrt2;
        //    a
        // d     b
        //    c
        var aTheta = -pi + theta - pi4;
        var dTheta = -pi + theta + pi/2 - pi/4;
        var cTheta = theta - pi4;
        var bTheta = -pi + theta - pi2 - pi4;
        var as = Math.sin( aTheta );
        var ac = Math.cos( aTheta );
        var bs = Math.sin( bTheta );
        var bc = Math.cos( bTheta );
        var cs = Math.sin( cTheta );
        var cc = Math.cos( cTheta );
        var ds = Math.sin( dTheta );
        var dc = Math.cos( dTheta );
        var r0 = r - thick;
        ax = px + r * as;
        ay = py + r * ac;
        bx = px + r * bs;
        by = py + r * bc;
        cx = px + r * cs;
        cy = py + r * cc;
        dx = px + r * ds;
        dy = py + r * dc;
        a0x = px + r0 * as;
        a0y = py + r0 * ac;
        b0x = px + r0 * bs;
        b0y = py + r0 * bc;
        c0x = px + r0 * cs;
        c0y = py + r0 * cc;
        d0x = px + r0 * ds;
        d0y = py + r0 * dc;
    } else {
        ax = px - radius;
        ay = py - radius;
        var lx = radius*2;
        var ly = lx;
        bx = ax + lx;
        by = ay;
        cx = bx;
        cy = ay + ly;
        dx = ax;
        dy = cy;
        var radius0 = radius - thick;
        a0x = px - radius0;
        a0y = py - radius0;
        var l0x = radius0*2;
        var l0y = l0x;
        b0x = a0x + l0x;
        b0y = a0y;
        c0x = b0x;
        c0y = a0y + l0y;
        d0x = a0x;
        d0y = c0y;
    }// top 
    // c bx, b0y
    // d ax, a0y
    add2DTriangle( paintType, ax, ay, bx, by, a0x, a0y );
    add2DTriangle( paintType, bx, by, b0x, b0y, a0x, a0y );
    // bottom
    // a dx d0y
    // b cx c0y
    add2DTriangle( paintType, d0x, d0y, c0x, c0y, dx, dy );
    add2DTriangle( paintType, c0x, c0y, cx, cy, dx, dy  );
    // left
    add2DTriangle( paintType, ax, ay, a0x, a0y, d0x, d0y );
    add2DTriangle( paintType, ax, ay, d0x, d0y, dx, dy );
    // right
    add2DTriangle( paintType, b0x, b0y, bx, by, c0x, c0y );
    add2DTriangle( paintType, bx, by, cx, cy, c0x, c0y );
    return 8;
}
//    a  b
//    d  c
inline
function square( paintType: PaintType
               , px: Float, py: Float
               , radius: Float, ?theta: Float = 0 ): Int {
    var ax = 0.;
    var ay = 0.;
    var bx = 0.;
    var by = 0.;
    var cx = 0.;
    var cy = 0.;
    var dx = 0.;
    var dy = 0.;
    if( theta != 0 ){
        var pi = Math.PI;
        var pi4 = pi/4;
        var pi2 = pi/2;
        var sqrt2 = Math.sqrt( 2 );
        var r = radius*sqrt2;
        //    a
        // d     b
        //    c
        var aTheta = -pi + theta - pi4;
        var dTheta = -pi + theta + pi/2 - pi/4;
        var cTheta = theta - pi4;
        var bTheta = -pi + theta - pi2 - pi4;
        ax = px + r * Math.sin( aTheta );
        ay = py + r * Math.cos( aTheta );
        bx = px + r * Math.sin( bTheta );
        by = py + r * Math.cos( bTheta );
        cx = px + r * Math.sin( cTheta );
        cy = py + r * Math.cos( cTheta );
        dx = px + r * Math.sin( dTheta );
        dy = py + r * Math.cos( dTheta );
    } else {
        ax = px - radius;
        ay = py - radius;
        var lx = radius*2;
        var ly = lx;
        bx = ax + lx;
        by = ay;
        cx = bx;
        cy = ay + ly;
        dx = ax;
        dy = cy;
    }
    return add2DQuad( paintType, ax, ay, bx, by, cx, cy, dx, dy );
}
inline 
function diamond( paintType: PaintType
                , x: Float, y: Float
                , radius: Float, ?theta: Float = 0. ): Int {
    return square( paintType, x, y, radius, Math.PI/4 + theta );
}
inline 
function diamondOutline( paintType: PaintType
                       , x: Float, y: Float
                       , thick: Float
                       , radius: Float, ?theta: Float = 0. ): Int {
    return squareOutline( paintType, x, y, radius, thick, Math.PI/4 + theta );
}
// use two overlapping triangles to create a quick star, lighter than say a circle for denoting a point.
inline
function overlapStar( paintType: PaintType
                    , px: Float, py: Float
                    , radius: Float, ?theta: Float = 0 ): Int {
    var pi = Math.PI;
    var omega: Float = -pi + theta;
    radius = radius/1.9;
    px += radius;
    py += radius;
    var a0x: Float = px + radius * Math.sin( omega );
    var a0y: Float = py + radius * Math.cos( omega );
    omega += pi/3;
    var a1x: Float = px + radius * Math.sin( omega );
    var a1y: Float = py + radius * Math.cos( omega );
    omega += pi/3;
    var b0x: Float = px + radius * Math.sin( omega );
    var b0y: Float = py + radius * Math.cos( omega );
    omega += pi/3;
    var b1x: Float = px + radius * Math.sin( omega );
    var b1y: Float = py + radius * Math.cos( omega );
    omega += pi/3;
    var c0x: Float = px + radius * Math.sin( omega );
    var c0y: Float = py + radius * Math.cos( omega );
    omega += pi/3;
    var c1x: Float = px + radius * Math.sin( omega );
    var c1y: Float = py + radius * Math.cos( omega );
    add2DTriangle( paintType, a0x, a0y, b0x, b0y, c0x, c0y );
    add2DTriangle( paintType, a1x, a1y, b1x, b1y, c1x, c1y );
    return 2;
}
inline
function circle( paintType: PaintType
               , ax: Float, ay: Float
               , radius: Float
               , ?sides: Int = 36, ?omega: Float = 0. ): Int {
    var pi: Float = Math.PI;
    var theta: Float = pi/2 + omega;
    var step: Float = pi*2/sides;
    var bx: Float;
    var by: Float;
    var cx: Float;
    var cy: Float;
    for( i in 0...sides ){
        bx = ax + radius*Math.sin( theta );
        by = ay + radius*Math.cos( theta );
        theta += step;
        cx = ax + radius*Math.sin( theta );
        cy = ay + radius*Math.cos( theta );
        add2DTriangle( paintType, ax, ay, bx, by, cx, cy );
    }
    return sides;
}
inline
function circleRadial( paintType: PaintType
               , ax: Float, ay: Float
               , rx: Float, ry: Float // -1 to 1 offset centre.
               , radius: Float
               , ?sides: Int = 36, ?omega: Float = 0. ): Int {
    var pi: Float = Math.PI;
    var theta: Float = pi/2 + omega;
    var step: Float = pi*2/sides;
    var bx: Float;
    var by: Float;
    var cx: Float;
    var cy: Float;
    if( rx > 1. ) rx = 1;
    if( rx < -1. ) rx = -1;
    if( ry > 1. ) ry = 1;
    if( ry < -1. ) ry = -1;
    var mx: Float = ax + rx*radius;
    var my: Float = ay - ry*radius;
    for( i in 0...sides ){
        bx = ax + radius*Math.sin( theta );
        by = ay + radius*Math.cos( theta );
        theta += step;
        cx = ax + radius*Math.sin( theta );
        cy = ay + radius*Math.cos( theta );
        add2DTriangle( paintType, mx, my, bx, by, cx, cy );
    }
    return sides;
}
inline
function circleRadialOnSide( paintType: PaintType
                     , ax: Float, ay: Float
                     , rx: Float, ry: Float // -1 to 1 offset centre.
                     , radius: Float, ?sides: Int = 36
                     , ?omega: Float = 0. ): Int {
    var pi = Math.PI;
    var theta = pi/2;
    var step = pi*2/sides;
    theta -= step/2 + omega;
    var bx: Float = 0;
    var by: Float = 0;
    var cx: Float = 0;
    var cy: Float = 0;
    if( rx > 1. ) rx = 1;
    if( rx < -1. ) rx = -1;
    if( ry > 1. ) ry = 1;
    if( ry < -1. ) ry = -1;
    var mx: Float = ax + rx*radius;
    var my: Float = ay - ry*radius;
    var dx = ax + radius*Math.sin( theta );
    var dy = ay + radius*Math.cos( theta );
    for( i in 0...( sides-1) ){
        bx = ax + radius*Math.sin( theta );
        by = ay + radius*Math.cos( theta );
        theta += step;
        cx = ax + radius*Math.sin( theta );
        cy = ay + radius*Math.cos( theta );
        add2DTriangle( paintType, mx, my, bx, by, cx, cy );
    }
    add2DTriangle( paintType, mx, my, cx, cy, dx, dy ); // will not render without?
    //add2DTriangle( paintType, mx, my, cx, cy, dx, dy );
    return sides;
}
inline 
function ellipse( paintType: PaintType
                , ax: Float, ay: Float
                , rx: Float, ry: Float
                , sides: Int = 36 ): Int {
    var pi = Math.PI;
    var theta = pi/2;
    var step = pi*2/sides;
    var bx: Float;
    var by: Float;
    var cx: Float;
    var cy: Float;
    for( i in 0...sides ){
        bx = ax + rx*Math.sin( theta );
        by = ay + ry*Math.cos( theta );
        theta += step;
        cx = ax + rx*Math.sin( theta );
        cy = ay + ry*Math.cos( theta );
        add2DTriangle( paintType, ax, ay, bx, by, cx, cy );
    }
    return sides;
}
/**
 * When calling Pie you can specify the DifferencePreference of what should be colored in terms of the two angles provided.
 * For example for drawing a packman shape you would want the use DifferencePreference.LARGE .
 **/
inline
function pie( paintType: PaintType
            , ax: Float, ay: Float
            , radius: Float, beta: Float, gamma: Float
            , prefer: DifferencePreference 
            , ?sides: Int = 36 ): Int {
    // choose a step size based on smoothness ie number of sides expected for a circle
    var pi = Math.PI;
    var step = pi*2/sides;
    var dif = Angles.differencePrefer( beta, gamma, prefer );
    var positive = ( dif >= 0 );
    var totalSteps = Math.ceil( Math.abs( dif )/step );
    // adjust step with smaller value to fit the angle drawn.
    var step = dif/totalSteps;
    var angle: Float = beta;
    var cx: Float;
    var cy: Float;
    var bx: Float = 0;
    var by: Float = 0;
    for( i in 0...totalSteps+1 ){
        cx = ax + radius*Math.sin( angle );
        cy = ay + radius*Math.cos( angle );
        if( i != 0 ){ // start on second iteration after b is populated.
            //var t = ( positive )? new Trilateral( ax, ay, bx, by, cx, cy ): new Trilateral( ax, ay, cx, cy, bx, by );
            add2DTriangle( paintType, ax, ay, bx, by, cx, cy );
        }
        angle = angle + step;
        bx = cx;
        by = cy;
    }
    return totalSteps;
}
/**
 * When calling Pie you can specify the DifferencePreference of what should be colored in terms of the two angles provided.
 * For example for drawing a packman shape you would want the use DifferencePreference.LARGE .
 **/
inline
function pieX( paintType: PaintType
            , ax: Float, ay: Float
            , radius:   Float, beta: Float, gamma: Float
            , prefer:   DifferencePreference
            , edgePoly: Array<Float>
            , ?sides: Int = 36 ): Int {
    // choose a step size based on smoothness ie number of sides expected for a circle
    var pi = Math.PI;
    var step = pi*2/sides;
    var dif = Angles.differencePrefer( beta, gamma, prefer );
    var positive = ( dif >= 0 );
    var totalSteps = Math.ceil( Math.abs( dif )/step );
    // adjust step with smaller value to fit the angle drawn.
    var step = dif/totalSteps;
    var angle: Float = beta;
    var cx: Float;
    var cy: Float;
    var bx: Float = 0;
    var by: Float = 0;
    var p2 = edgePoly.length;
    for( i in 0...totalSteps+1 ){
        cx = ax + radius*Math.sin( angle );
        cy = ay + radius*Math.cos( angle );
        edgePoly[ p2++ ] = cx;
        edgePoly[ p2++ ] = cy;
        if( i != 0 ){ // start on second iteration after b is populated.
            //var t = ( positive )? new Trilateral( ax, ay, bx, by, cx, cy ): new Trilateral( ax, ay, cx, cy, bx, by );
            add2DTriangle( paintType, ax, ay, bx, by, cx, cy );
        }
        angle = angle + step;
        bx = cx;
        by = cy;
    }
    return totalSteps;
}
/**
 * Optimized Pie used in Contour, with dif pre-calculated
 * External edge also added
 **/
inline
function pieDifX( paintType: PaintType
            , ax: Float, ay: Float
            , radius: Float, beta: Float, dif: Float
            , edgePoly: Array<Float>
            , ?sides: Int = 36 ): Int {
    // choose a step size based on smoothness ie number of sides expected for a circle
    var pi = Math.PI;
    var step = pi*2/sides;
    var positive = ( dif >= 0 );
    var totalSteps = Math.ceil( Math.abs( dif )/step );
    // adjust step with smaller value to fit the angle drawn.
    var step = dif/totalSteps;
    var angle: Float = beta;
    var cx: Float;
    var cy: Float;
    var bx: Float = 0;
    var by: Float = 0;
    var p2 = edgePoly.length;
    for( i in 0...totalSteps+1 ){
        cx = ax + radius*Math.sin( angle );
        cy = ay + radius*Math.cos( angle );
        edgePoly[ p2++ ] = cx;
        edgePoly[ p2++ ] = cy;
        if( i != 0 ){ // start on second iteration after b is populated.
            //var t = ( positive )? new Trilateral( ax, ay, bx, by, cx, cy ): new Trilateral( ax, ay, cx, cy, bx, by );
            add2DTriangle( paintType, ax, ay, bx, by, cx, cy );
        }
        angle = angle + step;
        bx = cx;
        by = cy;
    }
    return totalSteps;
}

inline
function ellipsePie( paintType: PaintType
                   , ax: Float, ay: Float
                   , rx: Float, ry: Float
                   , beta: Float, gamma: Float
                   , prefer: DifferencePreference
                   , ?sides: Int = 36 ): Int {
    // choose a step size based on smoothness ie number of sides expected for a circle
    var pi = Math.PI;
    var step = pi*2/sides;
    var dif = Angles.differencePrefer( beta, gamma, prefer );
    var positive = ( dif >= 0 );
    var totalSteps = Math.ceil( Math.abs( dif )/step );
    // adjust step with smaller value to fit the angle drawn.
    var step = dif/totalSteps;
    var angle: Float = beta;
    var cx: Float;
    var cy: Float;
    var bx: Float = 0;
    var by: Float = 0;
    for( i in 0...totalSteps+1 ){
        cx = ax + rx*Math.sin( angle );
        cy = ay + ry*Math.cos( angle );
        if( i != 0 ){ // start on second iteration after b is populated.
            //var t = ( positive )? new Trilateral( ax, ay, bx, by, cx, cy ): new Trilateral( ax, ay, cx, cy, bx, by );
            add2DTriangle( paintType, ax, ay, bx, by, cx, cy );
        }
        angle = angle + step;
        bx = cx;
        by = cy;
    }
    return totalSteps;
}
/**
 * Optimized Pie used in Contour, with dif pre-calculated
 **/
inline
function pieDif( paintType: PaintType
               , ax: Float, ay: Float
               , radius: Float, beta: Float
               , dif: Float, ?sides: Int = 36 ): Int {
    // choose a step size based on smoothness ie number of sides expected for a circle
    var pi = Math.PI;
    var step = pi*2/sides;
    var positive = ( dif >= 0 );
    var totalSteps = Math.ceil( Math.abs( dif )/step );
    // adjust step with smaller value to fit the angle drawn.
    var step = dif/totalSteps;
    var angle: Float = beta;
    var cx: Float;
    var cy: Float;
    var bx: Float = 0;
    var by: Float = 0;
    for( i in 0...totalSteps+1 ){
        cx = ax + radius*Math.sin( angle );
        cy = ay + radius*Math.cos( angle );
        if( i != 0 ){ // start on second iteration after b is populated.
            add2DTriangle( paintType, ax, ay, bx, by, cx, cy );
        }
        angle = angle + step;
        bx = cx;
        by = cy;
    }
    return totalSteps;
}
inline
function arc( paintType: PaintType
            , ax: Float, ay: Float
            , radius: Float, width: Float, beta: Float, gamma: Float
            , prefer: DifferencePreference, ?sides: Int = 36 ): Int {
    // choose a step size based on smoothness ie number of sides expected for a circle
    var pi = Math.PI;
    var step = pi*2/sides;
    var dif = Angles.differencePrefer( beta, gamma, prefer );
    var positive = ( dif >= 0 );
    var totalSteps = Math.ceil( Math.abs( dif )/step );
    // adjust step with smaller value to fit the angle drawn.
    var step = dif/totalSteps;
    var angle: Float = beta;
    var cx: Float;
    var cy: Float;
    var bx: Float = 0;
    var by: Float = 0;
    var dx: Float = 0;
    var dy: Float = 0;
    var ex: Float = 0;
    var ey: Float = 0;
    var r2 = radius - width;
    for( i in 0...totalSteps+1 ){
        cx = ax + radius*Math.sin( angle );
        cy = ay + radius*Math.cos( angle );
        ex = ax + r2*Math.sin( angle );
        ey = ay + r2*Math.cos( angle );
        if( i != 0 ){ // start on second iteration after b and d are populated.
            add2DTriangle( paintType, dx, dy, bx, by, cx, cy );
            add2DTriangle( paintType, dx, dy, cx, cy, ex, ey );
        }
        angle = angle + step;
        bx = cx;
        by = cy;
        dx = ex;
        dy = ey;
    }
    return totalSteps*2;
}
inline
function circleOnSide( paintType: PaintType
                     , ax: Float, ay: Float
                     , radius: Float, ?sides: Int = 36
                     , ?omega: Float = 0. ): Int {
    var pi = Math.PI;
    var theta = pi/2;
    var step = pi*2/sides;
    theta -= step/2 + omega;
    var bx: Float;
    var by: Float;
    var cx: Float;
    var cy: Float;
    for( i in 0...sides ){
        bx = ax + radius*Math.sin( theta );
        by = ay + radius*Math.cos( theta );
        theta += step;
        cx = ax + radius*Math.sin( theta );
        cy = ay + radius*Math.cos( theta );
        add2DTriangle( paintType, ax, ay, bx, by, cx, cy );
    }
    return sides;
}
inline 
function ellipseOnSide( paintType: PaintType
                      , ax: Float, ay: Float
                      , rx: Float, ry: Float
                      , sides: Int = 36 ): Int {
    var pi = Math.PI;
    var theta = pi/2;
    var step = pi*2/sides;
    theta -= step/2;
    var bx: Float;
    var by: Float;
    var cx: Float;
    var cy: Float;
    for( i in 0...sides ){
        bx = ax + rx*Math.sin( theta );
        by = ay + rx*Math.cos( theta );
        theta += step;
        cx = ax + rx*Math.sin( theta );
        cy = ay + ry*Math.cos( theta );
        add2DTriangle( paintType, ax, ay, bx, by, cx, cy );
    }
    return sides;
}
inline
function shape( paintType: PaintType
              , x: Float, y: Float
              , radius: Float, p: PolyEdge, ?omega: Float = 0. ): Int {
    return if( p & 1 == 0 ){
        circleOnSide( paintType, x, y, radius, p, omega );
    } else {
        circle( paintType, x, y, radius, p, omega );
    }
}
inline
function shapeRadial( paintType: PaintType
              , x: Float, y: Float
              , rx: Float, ry: Float
              , radius: Float, p: PolyEdge, ?omega: Float = 0. ): Int {
    return if( ( p & 1 ) == 0 ){
        //trace('even');
        circleRadial( paintType, x, y, rx, ry, radius, p, omega );
    } else {
        //trace('odd');
        //trace( p & 1 );
        circleRadialOnSide( paintType, x, y, rx, ry, radius, p, omega );
        
    }
}
inline
function roundedRectangle( paintType: PaintType
                         , x: Float, y: Float
                         , width: Float, height: Float
                         , radius: Float ): Int {
    // zero = down
    // clockwise seems to be wrong way round !
    // Needs fixing in Contour so can't change yet!
    // so all the angles are currently wrong!!
    var pi = Math.PI;
    var pi_2 = Math.PI/2;
    var ax = x + radius;
    var ay = y + radius;
    var bx = x + width - radius;
    var by = y + radius;
    var cx = bx;
    var cy = y + height - radius;
    var dx = ax;
    var dy = cy;
    var count = 0;
    count += rectangle( paintType, ax, y, width - radius*2, height );
    var dimY = height - 2*radius;
    count += rectangle( paintType, x,  ay, radius, dimY );
    count += rectangle( paintType, bx, by, radius, dimY );
    count += pie( paintType, ax, ay, radius, -pi, -pi_2, CLOCKWISE );
    count += pie( paintType, bx, by, radius, pi_2, pi,   CLOCKWISE );
    count += pie( paintType, cx, cy, radius, pi_2, 0,  ANTICLOCKWISE );
    count += pie( paintType, dx, dy, radius, 0, -pi_2, ANTICLOCKWISE );
    return count;
}
inline
function roundedRectangleOutline( paintType: PaintType
                                , x: Float, y: Float
                                , width: Float, height: Float
                                , thick: Float, radius: Float ): Int {
    // zero = down
    // clockwise seems to be wrong way round !
    // Needs fixing in Contour so can't change yet!
    // so all the angles are currently wrong!!
    var pi = Math.PI;
    var pi_2 = Math.PI/2;
    var ax = x + radius;
    var ay = y + radius;
    var bx = x + width - radius;
    var by = y + radius;
    var cx = bx;
    var cy = y + height - radius;
    var dx = ax;
    var dy = cy;
    var count = 0;
    count += rectangle( paintType, ax, y, width - radius*2, thick );
    count += rectangle( paintType, ax, y + height - thick, width - radius*2, thick );
    var dimY = height - 2*radius;
    count += rectangle( paintType, x,  ay, thick, dimY );
    count += rectangle( paintType, x + width - thick, by, thick, dimY );
    count += arc( paintType, ax, ay, radius, thick, -pi, -pi_2, CLOCKWISE );
    count += arc( paintType, bx, by, radius, thick, pi_2, pi,   CLOCKWISE );
    count += arc( paintType, cx, cy, radius, thick, pi_2, 0, ANTICLOCKWISE );
    count += arc( paintType, dx, dy, radius, thick, 0, -pi_2,ANTICLOCKWISE );
    return count;
}
inline
function spiralLines( paintType: PaintType
                    , x: Float, y: Float
                    , radius: Float, nolines: Int
                    , startWid: Float, stepWid: Float ): Int {
    var theta = 0.;
    var wid = startWid;
    for( i in 0...nolines ){
        lineXY( paintType, x, y
              , x + radius*Math.sin( theta )
              , y + radius*Math.cos( theta ), wid+= stepWid );
        theta += (Math.PI*2)/nolines;
    }
    return nolines;
}

class Shaper {
    public var add2DTriangle_: ( paintType: PaintType
                               , ax: Float, ay: Float
                               , bx: Float, by: Float
                               , cx: Float, cy: Float ) -> Int = add2DTriangle;
    public var add2DQuad_: ( paintType: PaintType
                           , ax: Float, ay: Float
                           , bx: Float, by: Float
                           , cx: Float, cy: Float
                           , dx: Float, dy: Float ) -> Int = add2DQuad;
    public var quad_: ( paintType: PaintType, q: Quad2D ) -> Int = quad;
    public var lineAB_: ( paintType: PaintType
                        , A: XY, B: XY
                        , width: Float ) -> Int = lineAB;
    public var lineXY_: ( paintType: PaintType
                     , ax: Float, ay: Float, bx: Float, by: Float
                     , width: Float ) -> Int = lineXY;
    public var rectangle_: ( paintType: PaintType
                           , x: Float, y: Float
                           , w: Float, h: Float ) -> Int = rectangle;
    public var squareOutline_: ( paintType: PaintType
                               , px: Float, py: Float
                               , radius: Float, thick: Float, ?theta: Float ) -> Int = squareOutline;
    public var square_: ( paintType: PaintType
                        , px: Float, py: Float
                        , radius: Float, ?theta: Float ) -> Int = square;
    public var diamond_: ( paintType: PaintType
                         , x: Float, y: Float
                         , radius: Float, ?theta: Float ) -> Int = diamond;
    public var diamondOutline_: ( paintType: PaintType
                                , x: Float, y: Float
                                , thick: Float
                                , radius: Float, ?theta: Float ) -> Int = diamondOutline;
    public var overlapStar_: ( paintType: PaintType
                             , px: Float, py: Float
                             , radius: Float, ?theta: Float ) -> Int = overlapStar;
    public var circle_: ( paintType: PaintType
                        , ax: Float, ay: Float
                        , radius: Float
                        , ?sides: Int, ?omega: Float ) -> Int = circle;
    public var circleRadial_: ( paintType: PaintType
                              , ax: Float, ay: Float
                              , rx: Float, ry: Float // -1 to 1 offset centre.
                              , radius: Float
                              , ?sides: Int, ?omega: Float ) -> Int = circleRadial;
    public var circleRadialOnSide_: ( paintType: PaintType
                                    , ax: Float, ay: Float
                                    , rx: Float, ry: Float // -1 to 1 offset centre.
                                    , radius: Float, ?sides: Int
                                    , ?omega: Float ) -> Int = circleRadialOnSide;
    public var ellipse_: ( paintType: PaintType
                         , ax: Float, ay: Float
                         , rx: Float, ry: Float
                         , sides: Int ) -> Int = ellipse;
    public var pie_: ( paintType: PaintType
                     , ax: Float, ay: Float
                     , radius: Float, beta: Float, gamma: Float
                     , prefer: DifferencePreference 
                     , ?sides: Int ) -> Int = pie;
    public var pieX_: ( paintType: PaintType
                      , ax: Float, ay: Float
                      , radius:   Float, beta: Float, gamma: Float
                      , prefer:   DifferencePreference
                      , edgePoly: Array<Float>
                      , ?sides: Int ) -> Int = pieX;
    public var pieDifX_: ( paintType: PaintType
                        , ax: Float, ay: Float
                        , radius: Float, beta: Float, dif: Float
                        , edgePoly: Array<Float>
                        , ?sides: Int ) -> Int = pieDifX;
    public var ellpisePie_: ( paintType: PaintType
                            , ax: Float, ay: Float
                            , rx: Float, ry: Float
                            , beta: Float, gamma: Float
                            , prefer: DifferencePreference
                            , ?sides: Int ) -> Int = ellipsePie;
    public var pieDif_: ( paintType: PaintType
                        , ax: Float, ay: Float
                        , radius: Float, beta: Float
                        , dif: Float, ?sides: Int ) -> Int = pieDif;
    public var arc_: ( paintType: PaintType
                     , ax: Float, ay: Float
                     , radius: Float, width: Float, beta: Float, gamma: Float
                     , prefer: DifferencePreference, ?sides: Int ) -> Int = arc;
    public var circleOnSide_: ( paintType: PaintType
                              , ax: Float, ay: Float
                              , radius: Float, ?sides: Int
                              , ?omega: Float ) -> Int = circleOnSide;
    public var ellipseOnSide_: ( paintType: PaintType
                               , ax: Float, ay: Float
                               , rx: Float, ry: Float
                               , sides: Int ) -> Int = ellipseOnSide;
    public var shape_: ( paintType: PaintType
                       , x: Float, y: Float
                       , radius: Float, p: PolyEdge, ?omega: Float ) -> Int = shape;
    public var shapeRadial_: ( paintType: PaintType
                             , x: Float, y: Float
                             , rx: Float, ry: Float
                             , radius: Float, p: PolyEdge, ?omega: Float ) -> Int = shapeRadial;
    public var roundedRectangle_: ( paintType: PaintType
                                  , x: Float, y: Float
                                  , width: Float, height: Float
                                  , radius: Float ) -> Int = roundedRectangle;
    public var roundedRectangleOutline_: ( paintType: PaintType
                                         , x: Float, y: Float
                                         , width: Float, height: Float
                                         , thick: Float, radius: Float ) -> Int = roundedRectangleOutline;
    public var spiralLines_: ( paintType: PaintType
                             , x: Float, y: Float
                             , radius: Float, nolines: Int
                             , startWid: Float, stepWid: Float ) -> Int = spiralLines;
}
