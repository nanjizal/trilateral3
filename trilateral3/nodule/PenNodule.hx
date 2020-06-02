package trilateral3.nodule;
import trilateral3.Trilateral;
import trilateral3.drawing.Pen;
import trilateral3.matrix.MatrixDozen;
import trilateral3.drawing.DrawAbstract;
import trilateral3.drawing.ColorAbstract;
import trilateral3.geom.FlatColorTriangles;
import haxe.io.Float32Array;
class PenNodule {
    static final largeEnough    = 20000000;
    public var colorTriangles   = new FlatColorTriangles( largeEnough );
    public var pen: Pen;
    public function new(){
        // assume scaling of 1000.
        var transform1000: MatrixDozen = { a : 0.001, b : 0, c : 0, d : -1
                                         , e : 0,  f : -0.001, g : 0, h : 1
                                         , i : 0, j : 0,k : 0.001, l : 0 };
        Trilateral.transformMatrix = transform1000;
        createPen();
    }
    public function createPen() {
       var t = colorTriangles;
       @:privateAccess
       var drawAbstract: DrawAbstract = {     triangle:       t.triangle
                                            , transform:      t.transform
                                            , transformRange: t.transformRange
                                            , getTriangle3D:  t.getTriangle3D
                                            , next:           t.next
                                            , hasNext:        t.hasNext
                                            , get_pos:        t.get_pos
                                            , set_pos:        t.set_pos
                                            , get_size:       t.get_size
                                            , set_size:       t.set_size
                                            };
       @:privateAccess
       var colorAbstract: ColorAbstract = {   cornerColors:   t.cornerColors
                                            , colorTriangles: t.colorTriangles
                                            , getTriInt:      t.getTriInt
                                            , get_pos:        t.get_pos
                                            , set_pos:        t.set_pos
                                            , get_size:       t.get_size
                                            , set_size:       t.set_size
                                            };
        pen = new Pen( drawAbstract , colorAbstract );
    }
    public var data( get, never ): Float32Array;
    public inline
    function get_data(): Float32Array {
        return colorTriangles.toArray();
    }
    public var size( get, never ): Int;
    public inline 
    function get_size(): Int{
        return Std.int( colorTriangles.size*3 );
    }
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