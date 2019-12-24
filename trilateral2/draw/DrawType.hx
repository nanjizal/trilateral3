package trilateral2; 
typedef DrawType = {
    var triangle: ( ax_: Float, ay_: Float, az_: Float
          , bx_: Float, by_: Float, bz_: Float
          , cx_: Float, cy_: Float, cz_: Float ) -> Bool;
    var next: ()->Float;
    var hasNext: ()->Bool;
    var pos: Float;
    var length: Float;
}
