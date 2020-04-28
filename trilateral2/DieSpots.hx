package trilateral2;
import trilateral2.Pen;
import geom.matrix.Matrix4x3;

@:forward
abstract DieSpots( Regular ) from Regular to Regular {
    public function new( regular: Regular ){
        this = regular;
    }
    public inline
    function six2( rs: RegularShape, dx: Float = 25, dy: Float = 35 ): IndexRange {
        var s0 = rs.clone();
        s0.x -= dx;
        s0.y -= dy;
        var c0 = this.circle2( s0 );
        
        var s1 = rs.clone();
        s1.x += dx;
        s1.y -= dy;
        var c1 = this.circle2( s1 );
        
        var s2 = rs.clone();
        s2.x -= dx;
        s2.y += dy;
        var c2 = this.circle2( s2 );
        
        var s3 = rs.clone();
        s3.x += dx;
        s3.y += dy;
        var c3 = this.circle2( s3 );
        
        var s4 = rs.clone();
        s4.x -= dx;
        var c4 = this.circle2( s4 );
        
        var s5 = rs.clone();
        s5.x += dx;
        var c5 = this.circle2( s5 );
        
        return { start: c0.start, end: c5.end };
    }
    public inline
    function five2( rs: RegularShape, dx: Float =  30, dy: Float = 30 ): IndexRange {
        var s0 = rs.clone();
        s0.x -= dx;
        s0.y -= dy;
        var c0 = this.circle2( s0 );
        
        var s1 = rs.clone();
        s1.x += dx;
        s1.y -= dy;
        var c1 = this.circle2( s1 );
        
        var s2 = rs.clone();
        s2.x -= dx;
        s2.y += dy;
        var c2 = this.circle2( s2 );
        
        var s3 = rs.clone();
        s3.x += dx;
        s3.y += dy;
        var c3 = this.circle2( s3 );
        
        var s4 = rs.clone();
        var c4 = this.circle2( s4 );
        
        return { start: c0.start, end: c4.end };
    }
    public inline
    function four2( rs: RegularShape, dx: Float =  30, dy: Float = 30 ): IndexRange {
        var s0 = rs.clone();
        s0.x -= dx;
        s0.y -= dy;
        var c0 = this.circle2( s0 );
        
        var s1 = rs.clone();
        s1.x += dx;
        s1.y -= dy;
        var c1 = this.circle2( s1 );
        
        var s2 = rs.clone();
        s2.x -= dx;
        s2.y += dy;
        var c2 = this.circle2( s2 );
        
        var s3 = rs.clone();
        s3.x += dx;
        s3.y += dy;
        var c3 = this.circle2( s3 );
        
        return { start: c0.start, end: c3.end };
    }
    public inline
    function three2( rs: RegularShape, dx: Float =  25, dy: Float = 25 ): IndexRange {
        var s0 = rs.clone();
        s0.x += dx;
        s0.y -= dy;
        var c0 = this.circle2( s0 );
        
        var s1 = rs.clone();
        s1.x -= dx;
        s1.y += dy;
        var c1 = this.circle2( s1 );
        
        var s2 = rs.clone();
        var c2 = this.circle2( s2 );
        
        return { start: c0.start, end: c2.end };
    }
    public inline
    function two2( rs: RegularShape, dx: Float =  20, dy: Float = 20 ): IndexRange {
        var s0 = rs.clone();
        s0.x += dx;
        s0.y -= dy;
        var c0 = this.circle2( s0 );
        
        var s1 = rs.clone();
        s1.x -= dx;
        s1.y += dy;
        var c1 = this.circle2( s1 );
        
        return { start: c0.start, end: c1.end };
    }
    public inline
    function one2( rs: RegularShape ): IndexRange {
        var s0 = rs.clone();
        var c0 = this.circle2( s0 );
        return { start: c0.start, end: c0.end };
    }
    public inline
    function six( rs: RegularShape, dx: Float = 25, dy: Float = 35 ): IndexRange {
        var s0 = rs.clone();
        s0.x -= dx;
        s0.y -= dy;
        var c0 = this.circle( s0 );
        
        var s1 = rs.clone();
        s1.x += dx;
        s1.y -= dy;
        var c1 = this.circle( s1 );
        
        var s2 = rs.clone();
        s2.x -= dx;
        s2.y += dy;
        var c2 = this.circle( s2 );
        
        var s3 = rs.clone();
        s3.x += dx;
        s3.y += dy;
        var c3 = this.circle( s3 );
        
        var s4 = rs.clone();
        s4.x -= dx;
        var c4 = this.circle( s4 );
        
        var s5 = rs.clone();
        s5.x += dx;
        var c5 = this.circle( s5 );
        
        return { start: c0.start, end: c5.end };
    }
    public inline
    function five( rs: RegularShape, dx: Float =  30, dy: Float = 30 ): IndexRange {
        var s0 = rs.clone();
        s0.x -= dx;
        s0.y -= dy;
        var c0 = this.circle( s0 );
        
        var s1 = rs.clone();
        s1.x += dx;
        s1.y -= dy;
        var c1 = this.circle( s1 );
        
        var s2 = rs.clone();
        s2.x -= dx;
        s2.y += dy;
        var c2 = this.circle( s2 );
        
        var s3 = rs.clone();
        s3.x += dx;
        s3.y += dy;
        var c3 = this.circle( s3 );
        
        var s4 = rs.clone();
        var c4 = this.circle( s4 );
        
        return { start: c0.start, end: c4.end };
    }
    public inline
    function four( rs: RegularShape, dx: Float =  30, dy: Float = 30 ): IndexRange {
        var s0 = rs.clone();
        s0.x -= dx;
        s0.y -= dy;
        var c0 = this.circle( s0 );
        
        var s1 = rs.clone();
        s1.x += dx;
        s1.y -= dy;
        var c1 = this.circle( s1 );
        
        var s2 = rs.clone();
        s2.x -= dx;
        s2.y += dy;
        var c2 = this.circle( s2 );
        
        var s3 = rs.clone();
        s3.x += dx;
        s3.y += dy;
        var c3 = this.circle( s3 );
        
        return { start: c0.start, end: c3.end };
    }
    public inline
    function three( rs: RegularShape, dx: Float =  25, dy: Float = 25 ): IndexRange {
        var s0 = rs.clone();
        s0.x += dx;
        s0.y -= dy;
        var c0 = this.circle( s0 );
        
        var s1 = rs.clone();
        s1.x -= dx;
        s1.y += dy;
        var c1 = this.circle( s1 );
        
        var s2 = rs.clone();
        var c2 = this.circle( s2 );
        
        return { start: c0.start, end: c2.end };
    }
    public inline
    function two( rs: RegularShape, dx: Float =  20, dy: Float = 20 ): IndexRange {
        var s0 = rs.clone();
        s0.x += dx;
        s0.y -= dy;
        var c0 = this.circle( s0 );
        
        var s1 = rs.clone();
        s1.x -= dx;
        s1.y += dy;
        var c1 = this.circle( s1 );
        
        return { start: c0.start, end: c1.end };
    }
    public inline
    function one( rs: RegularShape ): IndexRange {
        var s0 = rs.clone();
        var c0 = this.circle( s0 );
        return { start: c0.start, end: c0.end };
    }
}