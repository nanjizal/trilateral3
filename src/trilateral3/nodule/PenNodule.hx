package trilateral3.nodule;
import trilateral3.Trilateral;
import trilateral3.drawing.Pen;
import trilateral3.matrix.MatrixDozen;
import trilateral3.drawing.PaintAbstract;
import trilateral3.drawing.TriangleAbstract;
import trilateral3.drawing.Color3Abstract;
import trilateral3.geom.FlatColorTriangles;

#if useHyperKitGL
import hyperKitGL.io.Float32Array;
#else
import dsHelper.haxe.io.Float32Array;
#end

abstract class PenNodule {
    // assume that Float32Array structures are setup with inbuilt size... they are not! use Array instead.
    static var largeEnough    = 50;//1352;//1620; // assumes minimum of say about 50 triangles seems fair?
    public var pen: Pen;
    public function new( useGLScale: Bool = true ){
        if( useGLScale ){
            // assume scaling of 1000.
            var transform1000: MatrixDozen = { a : 0.001, b : 0,      c : 0, d : -1
                                             , e : 0,     f : -0.001, g : 0, h : 1
                                             , i : 0,     j : 0,      k : 0.001, l : 0 };
            Trilateral.transformMatrix = transform1000;
        }
        createPen();
    }
    abstract public function createPen(): Pen;
    public var data( get, never ): Float32Array;
    public
    abstract function get_data(): Float32Array;
    public var size( get, never ): Int;
    public
    abstract function get_size(): Int;
    // geom math example - don't remove.
    /*
    function scaleToGL():Matrix4x3{
        var scale = 1/(mainTexture.width);
        var v = new Matrix1x4( { x: scale, y: -scale, z: scale, w: 1. } );
        var m: Matrix4x3 = Matrix4x3.unit;
        return ( Matrix4x3.unit.translateXYZ( -1., 1., 0. ) ).scaleByVector( v );
    }
    */
}
