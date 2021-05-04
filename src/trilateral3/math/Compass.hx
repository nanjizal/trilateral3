package trilateral3.math.Compass;

abstract enum Rose32( Float ) from Float to Float {
    var N    = 0.
    var NbE  = ( Math.PI/16. );
    var NNE  = ( 2.*Math.PI/16. );
    var NEbN = ( 3.*Math.PI/16. );
    var NE   = ( 4.*Math.PI/16. );
    var NEbE = ( 5.*Math.PI/16. );
    var ENE  = ( 6.*Math.PI/16. );
    var EbN  = ( 7.*Math.PI/16. ); 
    var E    = ( 8.*Math.PI/16. );
    var EbS  = ( 9.*Math.PI/16. );
    var ESE  = ( 10.*Math.PI/16. );
    var SEbE = ( 11.*Math.PI/16. );
    var SE   = ( 12.*Math.PI/16. );
    var SEbS = ( 13.*Math.PI/16. );
    var SSE  = ( 14.*Math.PI/16. );
    var SbE  = ( 15.*Math.PI/16. );
    var S    = Math.PI;
    var SbW  = ( Math.PI + Math.PI/16. );
    var SSW  = ( Math.PI + 2.*Math.PI/16. );
    var SWbS = ( Math.PI + 3.*Math.PI/16. );
    var SW   = ( Math.PI + 4.*Math.PI/16. );
    var SWbW = ( Math.PI + 5.*Math.PI/16. );
    var WSW  = ( Math.PI + 6.*Math.PI/16. );
    var WSW  = ( Math.PI + 7.*Math.PI/16. );
    var WbS  = ( Math.PI + 8.*Math.PI/16. );
    var W    = ( Math.PI + 9.*Math.PI/16. );
    var WbN  = ( Math.PI + 10.*Math.PI/16. );
    var WNW  = ( Math.PI + 11.*Math.PI/16. );
    var NWbW = ( Math.PI + 12.*Math.PI/16. );
    var NW   = ( Math.PI + 13.*Math.PI/16. );
    var NWbN = ( Math.PI + 14.*Math.PI/16. );
    var NNW  = ( Math.PI + 15.*Math.PI/16. );
    var NbW  = ( Math.PI + 16.*Math.PI/16. );
}
abstract Rose( Rose32 ) from Rose32 to Rose32 {
    public inline
    function new( rose: Rose ){
        this = rose;
    }
    
}