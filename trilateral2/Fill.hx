package trilateral2;
// compiles, but untested.
import org.poly2tri.VisiblePolygon;
import hxGeomAlgo.Tess2;
import hxPolyK.PolyK;
class Fill {
    public static
    function triangulate( p: Array<Array<Float>>, fillForm: FillForm ): { vert: Array<Float>, tri: Array<Int> } {
        var vert: Array<Float>;
        var tri: Array<Int>;
        switch( fillForm ){
            case FillForm.tess2:
            
                var res = Tess2.tesselate( p, null, ResultType.POLYGONS, 3 );
                vert = res.vertices;
                tri = res.elements;
            
            case FillForm.poly2tri:
            
                var vp = new VisiblePolygon();
                var l = p.length;
                var p_: Array<Float>;
                for( i in 0...l ){
                    p_ = p[ i ];
                    if( p_.length != 0 ) {
                        var p2t: Array<org.poly2tri.Point> = [];
                        var pairs = new ArrayPairs<Float>( p_ );
                        var p0 = pairs[0].x;
                        var p1 = pairs[0].y;
                        for( pair in pairs ) p2t.push( new org.poly2tri.Point( pair.x, pair.y ) );
                        var l2 = p2t.length;
                        if( p0 == p2t[ l2 - 1 ].x && p1 == p2t[ l2 - 1 ].y ){
                            p2t.pop();
                        }
                        vp.addPolyline( p2t );
                    }
                }
                vp.performTriangulationOnce();
                var pt = vp.getVerticesAndTriangles();
                tri = pt.triangles;
                vert = pt.vertices;
            
            case FillForm.polyK:
            
                var l = p.length;
                var count = 0;
                vert = new Array<Float>();
                tri = new Array<Int>();
                for( i in 0...l ) if( p[ i ].length != 0 ) {
                    var poly = p[ i ];
                    var tgs = PolyK.triangulate( poly ); 
                    var triples = new ArrayTriple( tgs );
                    for( tri_ in triples ){
                        var a: Int = Std.int( tri_.a*2 );
                        var b: Int = Std.int( tri_.b*2 );
                        var c: Int = Std.int( tri_.c*2 );
                        vert.push( poly[ a ] );
                        vert.push( poly[ a + 1 ] );
                        tri.push( count++ );
                        vert.push( poly[ b ] );
                        vert.push( poly[ b + 1 ] );
                        tri.push( count++ );
                        vert.push( poly[ c ] );
                        vert.push( poly[ c + 1 ] );
                        tri.push( count++ );
                    }
                }
            
        }
        return { vert: vert, tri: tri };
    }
}
