package trilateral3.color;

inline
function getBlack( r: Float, g: Float, b: Float ): Float {
    return 1. - Math.max( Math.max( r, b ), g );
}
inline
function from_cymka( c: Float, y: Float, m: Float, k: Float, a: Float ): Int
    return from_argb( a
                , cymkConvert( c, k )
                , cymkConvert( m, k )
                , cymkConvert( y, k ) 
                );
inline
function from_argb( a: Float, r: Float, g: Float, b: Float ): Int
    return ( toHexInt( a ) << 24 ) 
         | ( toHexInt( r ) << 16 ) 
         | ( toHexInt( g ) << 8 ) 
         |   toHexInt( b );
inline
function toHexInt( c: Float ): Int
    return Math.round( c * 255 );
inline
function rgbConvert( color: Float, k: Float ): Float
    return ( 1. - color - k )/( 1.-k );
inline
function cymkConvert( color: Float, black: Float ): Float 
    return ( 1 - color / 100 ) * ( 1 - black / 100 );
inline
function alphaChannel( int: Int ) : Float
    return ((int >> 24) & 255) / 255;
inline
function redChannel( int: Int ) : Float
    return ((int >> 16) & 255) / 255;
inline
function greenChannel( int: Int ) : Float
    return ((int >> 8) & 255) / 255;
inline
function blueChannel( int: Int ) : Float
    return (int & 255) / 255;
class ColorHelper {
    public var getBlack_: ( r: Float, g: Float, b: Float ) -> Float = getBlack; 
    public var from_cymka_: ( c: Float, y: Float, m: Float, k: Float, a: Float ) -> Int = from_cymka;
    public var from_argb_: ( a: Float, r: Float, g: Float, b: Float ) -> Int = from_argb;
    public var toHexInt_: ( c: Float ) -> Int = toHexInt;
    public var rgbConvert_: ( color: Float, k: Float ) -> Float = rgbConvert;
    public var cymkConvert_: ( color: Float, black: Float ) -> Float = cymkConvert;
    public var alphaChannel_: ( int: Int ) -> Float = alphaChannel;
    public var redChannel_: ( int: Int ) -> Float = redChannel;
    public var greenChannel_: ( int: Int ) -> Float = greenChannel;
    public var blueChannel_: ( int: Int ) -> Float = blueChannel;
}