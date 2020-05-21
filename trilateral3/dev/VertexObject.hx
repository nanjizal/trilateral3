package trilateral3;
import geom.matrix.Quaternion;
import trilateral3.IndexRange;
import geom.matrix.DualQuaternion;
import geom.matrix.Matrix1x4;
import geom.matrix.Matrix4x3;
import geom.matrix.Quaternion;
import geom.obj.Tri3D;
// WIP may remove has rather tightly coupled to geom
@:forward
abstract VertexObject( DualQuaternionObject ) to DualQuaternionObject from DualQuaternionObject {
    public inline
    function new( o: DualQuaternionObject ){
        this = o;
    }
    @:from
    public static inline
    function create( mq: MatrixQuaternionObject ): VertexObject {
        var vo: VertexObject = new VertexObject({ name:     mq.name
                                                , centre:   DualQuaternion.create( mq.q, mq.m )
                                                , startEnd: mq.startEnd });
        return vo;
    }
    @:from
    public static inline 
    function createPos( mo: MatrixObject ): VertexObject {
        var q = Quaternion.zeroNormal; // ident
        var vo: VertexObject = new VertexObject({ name:     mo.name
                                                , centre:   DualQuaternion.create( q, mo.m )
                                                , startEnd: mo.startEnd } );
        return vo;
    }
    @:from
    public static inline 
    function createRotation( qo: QuaternionObject ): VertexObject {
        var m = Matrix1x4.unit;
        var vo: VertexObject = new VertexObject({ name:     qo.name
                                                , centre:   DualQuaternion.create( qo.q, m )
                                                , startEnd: qo.startEnd });
        return vo;
    }
    public inline
    function transform( dualQ: DualQuaternion ){
        this.centre = this.centre * dualQ;
    }
    /**
     *  gets the maximum radius from centre
     */
    public inline
    function getRadius3D( drawAbstract: DrawAbstract ): Float {
        var maxSquare = 0.;
        for( i in this.startEnd.start...this.startEnd.end ){
            drawAbstract.pos = i;
            var t3d = drawAbstract.getTri3D();
            var delta = t3d.magnitudeSquaredFrom( this.centre.getTranslation() );
            if( delta > maxSquare ) maxSquare = delta;
        }
        return Math.pow( maxSquare, 0.5 );
    }
    public inline
    function withinRadius3D( drawAbstract: DrawAbstract, p: Matrix1x4 ): Bool {
        var magDist = ( this.centre.getTranslation() - p ).magnitude;
        var b = ( magDist < getRadius3D( drawAbstract ) );
        return b;
    }
    /**
     gets the 2D radius from centre
    public inline
    function getRadius2D( drawType: DrawType ): Float {
        /*for( i in this.startEnd.start...this.startEnd.end ){
            // need to add get triangle methods
        }
    }*/
    
}

@:structInit
class DualQuaternionObject { 
    public var name:       String;
    public var centre:     DualQuaternion;
    public var startEnd:   IndexRange;
    public function new( name: String, centre: DualQuaternion, startEnd: IndexRange ){
        this.centre = centre;
        this.startEnd = startEnd;
    }
}

// converter helper types for construction
@:structInit
class MatrixQuaternionObject {
    public var name:     String;
    public var m:        Matrix1x4;
    public var q:        Quaternion;
    public var startEnd: IndexRange;
    public function new( name: String, q: Quaternion, m: Matrix1x4, startEnd: IndexRange ){
        this.name = name;
        this.q = q;
        this.m = m;
        this.startEnd = startEnd;
    }
}

@:structInit
class MatrixObject {
    public var name: String;
    public var m: Matrix1x4;
    public var startEnd: IndexRange;
    public function new( name: String, m: Matrix1x4, startEnd: IndexRange ){
        this.name = name;
        this.m = m;
        this.startEnd = startEnd;
    }
}

@:structInit
class QuaternionObject {
    public var name: String;
    public var q: Quaternion;
    public var startEnd: IndexRange;
    public function new( name: String, q: Quaternion, startEnd: IndexRange ){
        this.name = name;
        this.q = q;
        this.startEnd = startEnd;
    }
}
