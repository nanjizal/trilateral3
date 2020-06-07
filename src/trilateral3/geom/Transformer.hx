package trilateral3.geom;
import trilateral3.matrix.MatrixDozen;
import trilateral3.matrix.Vertex;
inline
function multiplyTransform( r: MatrixDozen, s: MatrixDozen ): MatrixDozen {
    var m: MatrixDozen = cast { a: r.a*s.a+r.b*s.e+r.c*s.i, b: r.a*s.b+r.b*s.f+r.c*s.j
                            , c: r.a*s.c+r.b*s.g+r.c*s.k, d: r.a*s.d+r.b*s.h+r.c*s.l+r.d
    , e: r.e*s.a+r.f*s.e+r.g*s.i, f: r.e*s.b+r.f*s.f+r.g*s.j
                            , g: r.e*s.c+r.f*s.g+r.g*s.k, h: r.e*s.d+r.f*s.h+r.g*s.l+r.h
    , i: r.i*s.a+r.j*s.e+r.k*s.i, j: r.i*s.b+r.j*s.f+r.k*s.j
                            , k: r.i*s.c+r.j*s.g+r.k*s.k, l: r.i*s.d+r.j*s.h+r.k*s.l+r.l
    };
    return m;
}
inline
function transformVertex( v: Vertex, t: MatrixDozen ): Vertex {
    var v2: Vertex = cast {  x: t.a * v.x + t.b * v.y + t.c * v.z + t.d
            , y: t.e * v.x + t.f * v.y + t.g * v.z + t.h
            , z: t.i * v.x + t.j * v.y + t.k * v.z + t.l  
            , w: 1. };
    return v2;
}
inline
function unitTransform(): MatrixDozen {
    var m: MatrixDozen = cast { a: 1., b: 0., c: 0., d: 0.
                              , e: 0., f: 1., g: 0., h: 0.
                              , i: 0., j: 0., k: 1., l: 0. };
    return m;
}
