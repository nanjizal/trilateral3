package trilateral3;
import trilateral3.Pen;
import geom.matrix.Matrix4x3;
import trilateral3.Shaper;

@:forward
abstract Regular( Pen ) from Pen to Pen {
    public function new( pen: Pen ){
        this = pen;
    }
    // All shape centred, quick equalateral shapes for simple graphs.
    public inline
    function triangle( rs: RegularShape ): IndexRange {
        return polygon( rs, PolySides.triangle );
    }
    public inline
    function triangle2( rs: RegularShape ): IndexRange {
        var se0 = triangle( rs );
        var se1 = triangle( rs );
        back( se1 );
        return { start: se0.start, end: se1.end };
    }
    public inline
    function square( rs: RegularShape ): IndexRange {
        return polygon( rs, PolySides.square );
    }
    public inline
    function square2( rs: RegularShape ): IndexRange {
        var se0 = square( rs );
        var se1 = square( rs );
        back( se1 );
        return { start: se0.start, end: se1.end };
    }
    public inline
    function bar( rs: RegularShape ): IndexRange {
        var start = this.drawType.size;
        var len = Shaper.rectangle( this.drawType, rs.x - rs.radius, rs.y - rs.radius/4
                                  , rs.radius*2, rs.radius/3 );
        this.colorTriangles( rs.color, len );
        var end = start + len - 1 ;
        return { start: start, end: end};
    }
    public inline
    function bar2( rs: RegularShape ): IndexRange {
        var se0 = bar( rs );
        var se1 = bar( rs );
        back( se1 );
        return { start: se0.start, end: se1.end };
    }
    public inline
    function pentagon( rs: RegularShape ): IndexRange {
        return polygon( rs, PolySides.pentagon );
    }
    public inline
    function pentagon2( rs: RegularShape ): IndexRange {
        var se0 = pentagon( rs );
        var se1 = pentagon( rs );
        back( se1 );
        return { start: se0.start, end: se1.end };
    }
    public inline
    function hexagon( rs: RegularShape ): IndexRange {
        return polygon( rs, PolySides.hexagon );
    }
    public inline
    function hexagon2( rs: RegularShape ): IndexRange {
        var se0 = hexagon( rs );
        var se1 = hexagon( rs );
        back( se1 );
        return { start: se0.start, end: se1.end };
    }
    public inline
    function circle( rs: RegularShape ): IndexRange {
        return polygon( rs );
    }
    public inline
    function circle2( rs: RegularShape ): IndexRange {
        var se0 = circle( rs );
        var se1 = circle( rs );
        back( se1 );
        return { start: se0.start, end: se1.end };
    }
    public inline
    function circleRadial( rs: RegularShape, colorCentre: Int, rx: Float, ry: Float ): IndexRange {
        return polygonRadial( rs, colorCentre, rx, ry );
    }
    public inline
    function circleRadial2( rs: RegularShape, colorCentre: Int, rx: Float, ry: Float ): IndexRange {
        var se0 = circleRadial( rs, colorCentre, rx, ry );
        var se1 = circleRadial( rs, colorCentre, -rx, -ry );
        back( se1 );
        return { start: se0.start, end: se1.end };
    }
    public inline
    function roundedSquare( rs: RegularShape  ): IndexRange {
        var start = this.drawType.size;
        var len = Shaper.roundedRectangle( this.drawType, rs.x - rs.radius, rs.y - rs.radius
                                         , rs.radius*2, rs.radius*2, this.rounded );
        this.colorTriangles( rs.color, len );
        var end = start + len - 1 ;
        return { start: start, end: end};
    }
    public inline
    function roundedSquare2( rs: RegularShape ): IndexRange {
        var se0 = roundedSquare( rs );
        var se1 = roundedSquare( rs );
        back( se1 );
        return { start: se0.start, end: se1.end };
    }
    public inline 
    function star( rs: RegularShape ): IndexRange {
        var start = this.drawType.size;
        var len = Shaper.overlapStar( this.drawType, rs.x - rs.radius, rs.y - rs.radius
                                    , rs.radius*2, rs.radius*2 );
        this.colorTriangles( rs.color, len );
        var end = start + len - 1 ;
        return { start: start, end: end};
    }
    public inline
    function star2( rs: RegularShape ): IndexRange {
        var se0 = star( rs );
        var se1 = star( rs );
        back( se1 );
        return { start: se0.start, end: se1.end };
    }
    public inline
    function transformRange( trans: Matrix4x3, ir: IndexRange ){
        this.drawType.transformRange( trans, ir.start, ir.end );
    }
    public inline
    function up( ir: IndexRange ){
        var trans = Matrix4x3.unit.translateZ( this.dz/2 );
        transformRange( trans, ir );
    }
    public inline
    function down( ir: IndexRange ){
        var trans = Matrix4x3.unit.translateZ( -this.dz/2 );
        transformRange( trans, ir );
    }
    public inline
    function back( ir: IndexRange ){
        transformRange( transBack(), ir );
    }
    inline
    function transBack(): Matrix4x3 {
        return Matrix4x3.unit.rotateX( Math.PI ) * Matrix4x3.unit.translateX( this.dz );
    }
    public inline
    function polygon( rs: RegularShape, sides: Int = 36 ): IndexRange {
        var start = this.drawType.size;
        var len = Shaper.circle( this.drawType, rs.x, rs.y, rs.radius, sides );
        this.colorTriangles( rs.color, len );
        var end: Int = start + len - 1;
        var startEnd: IndexRange = { start: start, end: end };
        return startEnd;
    }
    public inline
    function polygonRadial( rs: RegularShape, colorCentre: Int, rx: Float, ry: Float, sides: Int = 36 ): IndexRange {
        var start = this.drawType.size;
        var len = Shaper.shapeRadial( this.drawType, rs.x, rs.y, rx, ry, rs.radius, sides );
        this.middleColors( colorCentre, rs.color, len );
        var end: Int = start + len - 1;
        var startEnd: IndexRange = { start: start, end: end };
        return startEnd;
    }
    public inline
    function circleMultiCorners( rs: RegularShape, arr: Array<Int>, rx: Float = 0, ry: Float = 0 ):IndexRange {
        return polygonMultiCorners( rs, arr, rx, ry );
    }
    public inline
    function polygonMultiCorners( rs: RegularShape, arr: Array<Int>, rx: Float = 0, ry: Float = 0, sides: Int = 36 ): IndexRange {
        var start = this.drawType.size;
        var len = Shaper.shapeRadial( this.drawType, rs.x, rs.y, rx, ry, rs.radius, sides );
        //this.middleColors( arr[0], rs.color, len );
        var k = 1;
        var arrEnd = arr.length - 1;
        var end: Int = start + len - 1;
        var arr_ = arr.copy();
        for( j in 0...(len-1) ){
            this.cornerColors( rs.color, arr_[k-1], arr_[k] );
            k++;
            if( k > arrEnd ) {
                k = 1; // wrap
                arr_.reverse();
            }
        }
        this.cornerColors( rs.color, arr_[k-1], arr[0] );
        var startEnd: IndexRange = { start: start, end: end };
        return startEnd;
    }
}
