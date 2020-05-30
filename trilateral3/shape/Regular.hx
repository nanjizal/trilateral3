package trilateral3.shape;
import trilateral3.drawing.Pen;
import trilateral3.shape.Shaper;
import trilateral3.structure.RegularShape;
@:forward
abstract Regular( Pen ) from Pen to Pen {
    public function new( pen_: Pen ){
        this = pen_;
    }
    public inline 
    function addRegular( rs: RegularShape, style: StyleRegular ): IndexRange {
        return switch( style ){
            case TRIANGLE:
                triangle( rs );
            case SQUARE:
                square( rs );
            case BAR:
                bar( rs );
            case PENTAGON:
                pentagon( rs );
            case HEXAGON:
                hexagon( rs );
            case CIRCLE:
                circle( rs );
            case ROUNDSQUARE:
                roundedSquare( rs );
            case STAR:
                star( rs );
        }
    }
    // All shape centred, quick equalateral shapes for simple graphs.
    public inline
    function triangle( rs: RegularShape ): IndexRange {
        return polygon( rs, PolyEdge.triangle );
    }
    public inline
    function triangle2( rs: RegularShape ): IndexRange {
        var se0 = triangle( rs );
        var se1 = triangle( rs );
        this.back( se1 );
        return se0 + se1;
    }
    public inline
    function square( rs: RegularShape ): IndexRange {
        return polygon( rs, PolyEdge.tetragon );
    }
    public inline
    function square2( rs: RegularShape ): IndexRange {
        var se0 = square( rs );
        var se1 = square( rs );
        this.back( se1 );
        return se0 + se1;
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
        this.back( se1 );
        return se0 + se1;
    }
    public inline
    function pentagon( rs: RegularShape ): IndexRange {
        return polygon( rs, PolyEdge.pentagon );
    }
    public inline
    function pentagon2( rs: RegularShape ): IndexRange {
        var se0 = pentagon( rs );
        var se1 = pentagon( rs );
        this.back( se1 );
        return se0 + se1;
    }
    public inline
    function hexagon( rs: RegularShape ): IndexRange {
        return polygon( rs, PolyEdge.hexagon );
    }
    public inline
    function hexagon2( rs: RegularShape ): IndexRange {
        var se0 = hexagon( rs );
        var se1 = hexagon( rs );
        this.back( se1 );
        return se0 + se1;
    }
    public inline
    function circle( rs: RegularShape ): IndexRange {
        return polygon( rs );
    }
    public inline
    function circle2( rs: RegularShape ): IndexRange {
        var se0 = circle( rs );
        var se1 = circle( rs );
        this.back( se1 );
        return se0 + se1;
    }
    public inline
    function circleRadial( rs: RegularShape, colorCentre: Int, rx: Float, ry: Float ): IndexRange {
        return polygonRadial( rs, colorCentre, rx, ry );
    }
    public inline
    function circleRadial2( rs: RegularShape, colorCentre: Int, rx: Float, ry: Float ): IndexRange {
        var se0 = circleRadial( rs, colorCentre, rx, ry );
        var se1 = circleRadial( rs, colorCentre, -rx, -ry );
        this.back( se1 );
        return se0 + se1;
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
        this.back( se1 );
        return se0 + se1;
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
        this.back( se1 );
        return se0 + se1;
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
