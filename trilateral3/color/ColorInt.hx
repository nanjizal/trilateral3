package trilateral3.color;
import trilateral3.structure.ARGB;
import trilateral3.structure.CYMKA;
import trilateral3.color.ColorHelper;

abstract ColorInt( Int ) to Int from Int {
    public inline
    function new( v: Int ){
        this = v;
    }
    @:from
    static public inline
    function fromARGB( argb: ARGB ): ColorInt {
        return new ColorInt( from_argb( argb.a, argb.r, argb.g, argb.b ) );
    }
    @:to
    public inline
    function toARGB(): ARGB {
        return new ARGB( alpha, red, green, blue );
    }
    @:from
    static public inline
    function fromCYMKA( c: CYMKA ):ColorInt {
        return new ColorInt( from_cymka( c.c, c.y, c.m, c.k, c.a ) );
    }
    @:to
    public inline
    function toCYMK(): CYMKA {
        var k = black;
        var c = rgbConvert( red, k );
        var m = rgbConvert( green, k );
        var y = rgbConvert( blue, k );
        return new CYMKA( c, y, m, k, alpha );
    }
    public var cyan( get, set ): Float;
    inline
    function get_cyan(): Float {
        return rgbConvert( red, black );
    }
    inline 
    function set_cyan( v: Float ): Float {
        var k = black;
        var m = rgbConvert( green, k );
        var y = rgbConvert( blue, k );
        this = new ColorInt( from_cymka( v, y, m, k, alpha ) );
        return v;
    }
    public var yellow( get, set ): Float;
    inline
    function get_yellow(): Float {
        return rgbConvert( blue, black );
    }
    inline
    function set_yellow( v: Float ): Float {
        var k = black;
        var c = rgbConvert( red, k );
        var m = rgbConvert( green, k );
        this = new ColorInt( from_cymka( v, v, m, k, alpha ) );
        return v;
    }
    public var magenta( get, set ): Float;
    inline
    function get_magenta(): Float {
        return rgbConvert( green, black );
    }
    inline
    function set_magenta( v: Float ): Float {
        var k = black;
        var c = rgbConvert( red, k );
        var y = rgbConvert( blue, k );
        this = new ColorInt( from_cymka( c, y, v, k, alpha ) );
        return v;
    }
    public var black( get, set ): Float;
    inline function get_black(): Float {
        return getBlack( red, green, blue );
    }
    inline function set_black( v: Float ): Float {
        var k = black;
        var c = rgbConvert( red, k );
        var m = rgbConvert( green, k );
        var y = rgbConvert( blue, k );
        this = new ColorInt( from_cymka( c, y, m, v, alpha ) );
        return v;
    }
    public var alpha( get, set ): Float;
    inline
    function get_alpha(): Float {
        return alphaChannel( this );
    }
    inline
    function set_alpha( v: Float ): Float {
        this = new ColorInt( from_argb( v, red, green, blue ) );
        return v;
    }
    public var red( get, set ): Float;
    inline
    function get_red(): Float {
        return redChannel( this );
    }
    inline
    function set_red( v: Float ): Float {
        this = new ColorInt( from_argb( alpha, v, green, blue ) );
        return v;
    }
    public var green( get, set ): Float;
    inline
    function get_green(): Float {
        return greenChannel( this );
    }
    inline
    function set_green( v: Float ): Float {
        this = new ColorInt( from_argb( alpha, red, v, blue ) );
        return v;
    }
    public var blue( get, set ): Float;
    inline
    function get_blue(): Float {
        return blueChannel( this );
    }
    inline
    function set_blue( v: Float ): Float {
        this = new ColorInt( from_argb( alpha, red, green, v ) );
        return v;
    }
    // String CYMK typically created by ilustrator export from flash
    static public inline
    function stringCYMK( str: String, alpha: Float = 1.0 ): ColorInt {
        var arr = str.split(' ');
        return new ColorInt( from_cymka( Std.parseFloat( arr[0] )
                                       , Std.parseFloat( arr[1] )
                                       , Std.parseFloat( arr[2] )
                                       , Std.parseFloat( arr[2] ), alpha ) );
    }
    // not strictly part of this class, but kind of useful rather than going through Int
    // because has structures prefer not in colorHelper?
    static public inline
    function ARGB_CYMKA( v: ARGB ){
        var k = getBlack( v.r, v.g, v.b );
        var c = rgbConvert( v.r, k );
        var m = rgbConvert( v.g, k );
        var y = rgbConvert( v.b, k );
        return new CYMKA( c, y, m, k, v.a );
    }
    // not strictly part of this class, but kind of useful rather than going through Int
    // because has structures prefer not in colorHelper?
    static public inline
    function CYMKA_ARGB( v: CYMKA ): ARGB {
        var r = cymkConvert( v.c, v.k );
        var g = cymkConvert( v.m, v.k );
        var b = cymkConvert( v.y, v.k ); 
        return new ARGB( v.a, r, g, b );
    }
}