package trilateral2.draw;
enum abstract Wheel24( Int ) to Int from Int {
    var redRadish         = 0xffef3c42;
    var orangeSoda        = 0xfff25e40;
    var gokuOrange        = 0xfff2823a;
    var highlighterOrange = 0xfff69537;
    var carona            = 0xfff4aa2f;
    var solarPower        = 0xfff6c137;
    var flirtatious       = 0xfffad435;
    var yellowBellied     = 0xfffdf32f;
    var daffodil          = 0xffffff2d;
    var spoiledEgg        = 0xffdff429;
    var peraRocha         = 0xffa7d52a;
    var appleGreen        = 0xff79c725;
    var fieldGreen        = 0xff53c025;
    var parisGreen        = 0xff52c67f;
    var maximumBlue       = 0xff4daecf;
    var blueTourmaline    = 0xff4592ca;
    var celestialPlum     = 0xff3f77c4;
    var freeSpeechBlue    = 0xff3a57bf;
    var earlySpringNight  = 0xff3438bd;
    var blueDepression    = 0xff4b27bd;
    var nebulaFuchsia     = 0xff7328b6;
    var fuchsiaFlair      = 0xffb528c5;
    var royalFuchsia      = 0xffc32a94;
    var fuchsiaPurple     = 0xffdd3371;
}
class ColorWheel24{
    inline public static 
    function getWheel(){
        return  [ redRadish
                , orangeSoda
                , gokuOrange
                , highlighterOrange
                , carona
                , solarPower
                , flirtatious
                , yellowBellied
                , daffodil
                , spoiledEgg
                , peraRocha
                , appleGreen
                , fieldGreen
                , parisGreen
                , maximumBlue
                , blueTourmaline
                , celestialPlum
                , freeSpeechBlue
                , earlySpringNight
                , blueDepression
                , nebulaFuchsia
                , fuchsiaFlair
                , royalFuchsia
                , fuchsiaPurple ];
    }
    inline public static
    function random(){
        var wheel = getWheel();
        var rnd: Int = Math.round( Math.random()*23);
        return wheel[rnd];
    }
    inline public static
    function getName( w: Wheel24 ): String {
        return switch( w ){
            case redRadish:             'redRadish';
            case orangeSoda:            'orangeSoda';
            case gokuOrange:            'gokuOrange';
            case highlighterOrange:     'highlighterOrange';
            case carona:                'carona';
            case solarPower:            'solarPower';
            case flirtatious:           'flirtaious';
            case yellowBellied:         'yellowBellied';
            case daffodil:              'daffodil';
            case spoiledEgg:            'spoiledEgg';
            case peraRocha:             'peraRocha';
            case appleGreen:            'appleGreen';
            case fieldGreen:            'fieldGreen';
            case parisGreen:            'parisGreen';
            case maximumBlue:           'maximumBlue';
            case blueTourmaline:        'blueTourmaline';
            case celestialPlum:         'celestialPlum';
            case freeSpeechBlue:        'freeSpeechBlue';
            case earlySpringNight:      'earlySpringNight';
            case blueDepression:        'blueDepression';
            case nebulaFuchsia:         'nebulaFuschsia';
            case fuchsiaFlair:          'fushsiaFlair';
            case royalFuchsia:          'royalFuchsia';
            case fuchsiaPurple:         'fuchsiaPurple';
        }
    }
    inline public static
    function next( w: Wheel24 ){
        var wheel = getWheel();
        var i = wheel.indexOf( w );
        var v = ( i < 24 )? i + 1: 0;
        return wheel[ v ];
    }
}