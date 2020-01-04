package trilateral2;
import trilateral2.DrawType;
import trilateral2.Algebra;
import geom.obj.Quad2D;
import geom.matrix.Matrix1x2;
import fracs.Angles;
@:enum
abstract PolySides( Int ) from Int to Int {
    var triangle        = 3;
    var quadrilateral   = 4;
    var square          = 4;
    var tetragon        = 4;
    var pentagon        = 5;
    var hexagon         = 6;
    var heptagon        = 7;
    var septagon        = 7;
    var octagon         = 8;
    var nonagon         = 9;
    var enneagon        = 9;
    var decagon         = 10;
    var hendecagon      = 11;
    var undecagon       = 11;
    var dodecagon       = 12;
    var triskaidecagon  = 13;
    var tetrakaidecagon = 14;
    var pentadecagon    = 15;
    var hexakaidecagon  = 16;
    var heptadecagon    = 17;
    var octakaidecagon  = 18;
    var enneadecagon    = 19;
    var icosagon        = 20;
    var triacontagon    = 30;
    var tetracontagon   = 40;
    var pentacontagon   = 50;
    var hexacontagon    = 60;
    var heptacontagon   = 70;
    var octacontagon    = 80;
    var enneacontagon   = 90;
    var hectagon        = 100;
    var chiliagon       = 1000;
    var myriagon        = 10000;
}
/**
Shaper provides static methods for drawing with triangles.
the methods return the number of triangles added.
**/
class Shaper {
    public static inline
    function add2DTriangle( drawType: DrawType
                          , ax: Float, ay: Float
                          , bx: Float, by: Float
                          , cx: Float, cy: Float ): Int {
        // don't need to reorder corners and Trilateral can do that!
        drawType.triangle( ax, ay, 0, bx, by, 0, cx, cy, 0 );
        drawType.next();
        return 1;
    }
    public static inline
    function add2DQuad( drawType: DrawType
                      , ax: Float, ay: Float
                      , bx: Float, by: Float
                      , cx: Float, cy: Float
                      , dx: Float, dy: Float ): Int {
        add2DTriangle( drawType, ax, ay, bx, by, dx, dy );
        add2DTriangle( drawType, bx, by, cx, cy, dx, dy );
        return 2;
    }
    public static inline 
    function quad( drawType: DrawType, q: Quad2D ): Int {
        return add2DQuad( drawType,  q.A.x, q.A.y, q.B.x, q.B.y, q.C.x, q.C.y, q.D.x, q.D.y );
    }
    public static inline 
    function lineAB( drawType: DrawType
                   , A: Matrix1x2, B: Matrix1x2
                   , width: Float ): Int {
        var q = Algebra.lineAB( A, B, width );
        return quad( drawType, q );
    }
    public static inline 
    function lineXY( drawType: DrawType
                   , ax: Float, ay: Float, bx: Float, by: Float
                   , width: Float ): Int {
        var q = Algebra.lineABCoord( ax, ay, bx, by, width );
        return quad( drawType, q );
    }
    public inline static
    function rectangle( drawType: DrawType
        , x: Float, y: Float, w: Float, h: Float ): Int {
        var ax = x;
        var ay = y;
        var bx = x + w;
        var by = ay;
        var cx = bx;
        var cy = ay + h;
        var dx = x;
        var dy = cy; 
        return add2DQuad( drawType, ax, ay, bx, by, cx, cy, dx, dy );
    }
    //    a  b
    //    d  c
    public static inline
    function squareOutline( drawType: DrawType
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
        add2DTriangle( drawType, ax, ay, bx, by, a0x, a0y );
        add2DTriangle( drawType, bx, by, b0x, b0y, a0x, a0y );
        // bottom
        // a dx d0y
        // b cx c0y
        add2DTriangle( drawType, d0x, d0y, c0x, c0y, dx, dy );
        add2DTriangle( drawType, c0x, c0y, cx, cy, dx, dy  );
        // left
        add2DTriangle( drawType, ax, ay, a0x, a0y, d0x, d0y );
        add2DTriangle( drawType, ax, ay, d0x, d0y, dx, dy );
        // right
        add2DTriangle( drawType, b0x, b0y, bx, by, c0x, c0y );
        add2DTriangle( drawType, bx, by, cx, cy, c0x, c0y );
        return 8;
    }
    //    a  b
    //    d  c
    public static inline
    function square( drawType: DrawType
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
        return add2DQuad( drawType, ax, ay, bx, by, cx, cy, dx, dy );
    }
    public static inline 
    function diamond( drawType: DrawType
                    , x: Float, y: Float
                    , radius: Float, ?theta: Float = 0. ): Int {
        return square( drawType, x, y, radius, Math.PI/4 + theta );
    }
    public static inline 
    function diamondOutline( drawType: DrawType
                           , x: Float, y: Float
                           , thick: Float
                           , radius: Float, ?theta: Float = 0. ): Int {
        return squareOutline( drawType, x, y, radius, thick, Math.PI/4 + theta );
    }
    // use two overlapping triangles to create a quick star, lighter than say a circle for denoting a point.
    public inline static
    function overlapStar( drawType: DrawType
                        , px: Float, py: Float
                        , radius: Float, ?theta: Float = 0 ): Int {
        var pi = Math.PI;
        var omega: Float = -pi + theta;
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
        add2DTriangle( drawType, a0x, a0y, b0x, b0y, c0x, c0y );
        add2DTriangle( drawType, a1x, a1y, b1x, b1y, c1x, c1y );
        return 2;
    }
    public static inline
    function circle( drawType: DrawType
                   , ax: Float, ay: Float
                   , radius: Float
                   , ?sides: Int = 36, ?omega: Float = 0. ): Int {
        var pi = Math.PI;
        var theta = pi/2 + omega;
        var step = pi*2/sides;
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
            add2DTriangle( drawType, ax, ay, bx, by, cx, cy );
        }
        return sides;
    }
    public static inline 
    function ellipse( drawType: DrawType
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
            add2DTriangle( drawType, ax, ay, bx, by, cx, cy );
        }
        return sides;
    }
    /**
     * When calling Pie you can specify the DifferencePreference of what should be colored in terms of the two angles provided.
     * For example for drawing a packman shape you would want the use DifferencePreference.LARGE .
     **/
    public static inline
    function pie( drawType: DrawType
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
                add2DTriangle( drawType, ax, ay, bx, by, cx, cy );
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
    public static inline
    function pieX( drawType: DrawType
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
                add2DTriangle( drawType, ax, ay, bx, by, cx, cy );
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
    public static inline
    function pieDifX( drawType: DrawType
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
                add2DTriangle( drawType, ax, ay, bx, by, cx, cy );
            }
            angle = angle + step;
            bx = cx;
            by = cy;
        }
        return totalSteps;
    }
    
    public static inline
    function ellpisePie( drawType: DrawType
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
                add2DTriangle( drawType, ax, ay, bx, by, cx, cy );
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
    public static inline
    function pieDif( drawType: DrawType
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
                add2DTriangle( drawType, ax, ay, bx, by, cx, cy );
            }
            angle = angle + step;
            bx = cx;
            by = cy;
        }
        return totalSteps;
    }
    public static inline
    function arc( drawType: DrawType
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
                add2DTriangle( drawType, dx, dy, bx, by, cx, cy );
                add2DTriangle( drawType, dx, dy, cx, cy, ex, ey );
            }
            angle = angle + step;
            bx = cx;
            by = cy;
            dx = ex;
            dy = ey;
        }
        return totalSteps*2;
    }
        
    public static inline
    function circleOnSide( drawType: DrawType
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
            add2DTriangle( drawType, ax, ay, bx, by, cx, cy );
        }
        return sides;
    }
    public static inline 
    function ellipseOnSide( drawType: DrawType
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
            add2DTriangle( drawType, ax, ay, bx, by, cx, cy );
        }
        return sides;
    }
    public static inline
    function shape( drawType: DrawType
                  , x: Float, y: Float
                  , radius: Float, p: PolySides, ?omega: Float = 0. ): Int {
        return if( p & 1 == 0 ){
            circleOnSide( drawType, x, y, radius, p, omega );
        } else {
            circle( drawType, x, y, radius, p, omega );
        }
    }
    public static inline
    function roundedRectangle( drawType: DrawType
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
        count += rectangle( drawType, ax, y, width - radius*2, height );
        var dimY = height - 2*radius;
        count += rectangle( drawType, x,  ay, radius, dimY );
        count += rectangle( drawType, bx, by, radius, dimY );
        count += pie( drawType, ax, ay, radius, -pi, -pi_2, CLOCKWISE );
        count += pie( drawType, bx, by, radius, pi_2, pi,   CLOCKWISE );
        count += pie( drawType, cx, cy, radius, pi_2, 0,  ANTICLOCKWISE );
        count += pie( drawType, dx, dy, radius, 0, -pi_2, ANTICLOCKWISE );
        return count;
    }
    public static inline
    function roundedRectangleOutline( drawType: DrawType
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
        count += rectangle( drawType, ax, y, width - radius*2, thick );
        count += rectangle( drawType, ax, y + height - thick, width - radius*2, thick );
        var dimY = height - 2*radius;
        count += rectangle( drawType, x,  ay, thick, dimY );
        count += rectangle( drawType, x + width - thick, by, thick, dimY );
        count += arc( drawType, ax, ay, radius, thick, -pi, -pi_2, CLOCKWISE );
        count += arc( drawType, bx, by, radius, thick, pi_2, pi,   CLOCKWISE );
        count += arc( drawType, cx, cy, radius, thick, pi_2, 0, ANTICLOCKWISE );
        count += arc( drawType, dx, dy, radius, thick, 0, -pi_2,ANTICLOCKWISE );
        return count;
    }
    public static inline
    function spiralLines( drawType: DrawType
                        , x: Float, y: Float
                        , radius: Float, nolines: Int
                        , startWid: Float, stepWid: Float ): Int {
        var theta = 0.;
        var wid = startWid;
        for( i in 0...nolines ){
            lineXY( drawType, x, y
                  , x + radius*Math.sin( theta )
                  , y + radius*Math.cos( theta ), wid+= stepWid );
            theta += (Math.PI*2)/nolines;
        }
        return nolines;
    }
}
