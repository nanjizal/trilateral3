package trilateral3.shape.xtra;
import trilateral3.drawing.Pen;
import trilateral3.shape.Regular;
import trilateral3.structure.RegularShape;
//import geom.matrix.Matrix4x3;
import pallette.ColorWheel24;
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
        
        return c0 + c5;
    }
    public inline
    function colorSix( rs: RegularShape, dx: Float = 25, dy: Float = 35 ): IndexRange {
        var s0 = rs.clone();
        s0.x -= dx;
        s0.y -= dy;
        var c0 = this.polygonMultiCorners( s0, ColorWheel24.getWheel(), -0.25, 0.25, 47 );
        
        var s1 = rs.clone();
        s1.x += dx;
        s1.y -= dy;
        var c1 = this.polygonMultiCorners( s1, ColorWheel24.getWheel(), -0.25, 0.25, 47 );
        
        var s2 = rs.clone();
        s2.x -= dx;
        s2.y += dy;
        var c2 = this.polygonMultiCorners( s2, ColorWheel24.getWheel(), -0.25, 0.25, 47 );
        
        var s3 = rs.clone();
        s3.x += dx;
        s3.y += dy;
        var c3 = this.polygonMultiCorners( s3, ColorWheel24.getWheel(), -0.25, 0.25, 47 );
        
        var s4 = rs.clone();
        s4.x -= dx;
        var c4 = this.polygonMultiCorners( s4, ColorWheel24.getWheel(), -0.25, 0.25, 47 );
        
        var s5 = rs.clone();
        s5.x += dx;
        var c5 = this.polygonMultiCorners( s5, ColorWheel24.getWheel(), -0.25, 0.25, 47 );
        
        return c0 + c5;
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
        
        return c0 + c4;
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
        
        return c0 + c3;
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
        
        return c0 + c2;
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
        
        return c0 + c1;
    }
    public inline
    function one2( rs: RegularShape ): IndexRange {
        var s0 = rs.clone();
        var c0 = this.circle2( s0 );
        return c0;
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
        
        return c0 + c5;
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
        
        return c0 + c4;
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
        
        return c0 + c3;
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
        
        return c0 + c2;
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
        
        return c0 + c1;
    }
    public inline
    function one( rs: RegularShape ): IndexRange {
        var s0 = rs.clone();
        var c0 = this.circle( s0 );
        return c0;
    }
    public inline
    function colorOne( rs: RegularShape ): IndexRange {
        var s0 = rs.clone();
        var c0 = this.polygonMultiCorners( s0, ColorWheel24.getWheel(), -0.25, 0.25, 47 );
        return c0;
    }
    public inline
    function goldOne( rs: RegularShape ): IndexRange {
        var s0 = rs.clone();
        var c0 = this.polygonMultiCorners( s0, [0xffA37E2C,0xffD5A848,0xffE4B77D,0xffD4AF37,0xffFFDF00,0xffFCC200,0xffFFC627,0xffFFCC00,0xffFD8515,0xffC6930A,0xffFFd100,0xffF1B82D,0xffE6BE8A,0xffFFCC33,0xffDA9100,0xffDAA520,0xffC5B358,0xffCBA135, 0xff996515], 0.5, 0.5, 47 );
        return c0;
    }
}
