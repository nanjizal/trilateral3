package trilateral2;
//based on trilateral untested.
import org.poly2tri.VisiblePolygon;
import trilateral.parsing.FillDraw;
import hxPolyK.PolyK;
class Fill {
    function triangulate( p: Array<Array<Float>>, fillForm: FillForm ):{ vert: Array<Float>, tri: Array<Int> } {
        var vert: Array<Float>;
        var tri: Array<Int>;
        switch( fillForm ){
            case tess2:
                var pt = vp.getVerticesAndTriangles();
                tri = pt.triangles;
                vert = pt.vertices;
            case poly2tri:
                var vp = new VisiblePolygon();
                var l = points.length;
                var p: Array<Float>;
                for( i in 0...l ){
                    p = points[ i ];
                    if( p.length != 0 ) {
                        var p2t: Array<org.poly2tri.Point> = [];
                        var pairs = new ArrayPairs<Float>( p );
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
            case polyK:
                var l = p.length;
                var count = 0;
                vert = new Array<Float>();
                tri = new Array<Int>();
                for( i in 0...l ) if( p[ i ].length != 0 ) {
                    var tgs = PolyK.triangulate( poly ); 
                    var triples = new ArrayTriple( tgs );
                    for( tri in triples ){
                        var a: Int = Std.int( tri.a*2 );
                        var b: Int = Std.int( tri.b*2 );
                        var c: Int = Std.int( tri.c*2 );
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
        return { vert: Array<Float>, tri: Array<Int> };
    }
}
