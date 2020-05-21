package trilateral3;
import org.poly2tri.VisiblePolygon;
import hxGeomAlgo.Tess2;
import hxPolyK.PolyK;
class Fill {
    public static
    function triangulate( pen: Pen, sketch: Sketch, fillForm: FillForm ) {
        var vert: Array<Float>;
        var tri: Array<Int>;
        var p: Array<Array<Float>>;
        switch( fillForm ){
            case FillForm.tess2:
                sketch.pointsRewound();
                p = sketch.points;
                var res = Tess2.tesselate( p, null, ResultType.POLYGONS, 3 );
                vert = res.vertices;
                tri = res.elements;
                var triples = new ArrayTriple( tri );
                var i: Int;
                for( tri_ in triples ){
                    var a: Int = Std.int( tri_.a*2 );
                    var b: Int = Std.int( tri_.b*2 );
                    var c: Int = Std.int( tri_.c*2 );
                    pen.triangle2DFill(  vert[ a ], vert[ a + 1 ]
                                       , vert[ b ], vert[ b + 1 ]
                                       , vert[ c ], vert[ c + 1 ], -1 );
                }
                
            case FillForm.poly2tri:
                sketch.pointsNoEndOverlap();
                p = sketch.points;
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
                var triples = new ArrayTriple( tri );
                var i: Int;
                for( tri_ in triples ){
                    var a: Int = Std.int( tri_.a*3 );
                    var b: Int = Std.int( tri_.b*3 );
                    var c: Int = Std.int( tri_.c*3 );
                    pen.triangle2DFill(  vert[ a ], vert[ a + 1 ]
                                       , vert[ b ], vert[ b + 1 ]
                                       , vert[ c ], vert[ c + 1 ], -1 );
                }
                
            case FillForm.polyK:
                p = sketch.points;
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
                        pen.triangle2DFill( poly[ a ], poly[ a + 1 ],
                                            poly[ b ], poly[ b + 1 ], 
                                            poly[ c ], poly[ c + 1 ], -1 );
                    }
                }
            
        }
    }
}
