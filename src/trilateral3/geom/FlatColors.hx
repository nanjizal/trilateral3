package trilateral3.geom;

import trilateral3.structure.Triangle3D;
import trilateral3.matrix.MatrixDozen;
import trilateral3.shape.IndexRange;
import trilateral3.matrix.Vertex;
import trilateral3.geom.Transformer;
import trilateral3.structure.TriInt;
#if useHyperKitGL
import hyperKitGL.io.Float32FlatRGBA;
#else
import dsHelper.flat.f32.Float32FlatRGBA;
#end
@:transitive
@:forward
abstract FlatColors( dsHelper.flat.f32.Float32FlatRGBA ){
    public inline function new( len: Int ){
        this = new Float32FlatRGBA( len );
    }
    public inline
    function getTriInt(): TriInt {
        var a = this.argb;
        this.next();
        var b = this.argb;
        this.next();
        var c = this.argb;
        this.next();
        return { a: a, b: b, c: c };
    }
}