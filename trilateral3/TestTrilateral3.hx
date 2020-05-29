package trilateral3;
#if !trilateral3Doc
import utest.Runner;
import utest.Test;
import utest.ui.Report;
import equals.Equal;
import utest.Assert;
// subfolders
import trilateral3.*;
import trilatelal3.dev.*;
import trilateral3.drawing.*;
import trilateral3.geom.*;
import trilateral3.geom.flat.*;
import trilateral3.geom.obj.*;
import trilateral3.iter.*;
import trilateral3.math.*;
import trilateral3.shape.*;
import trilateral3.shape.xtra.*;
import trilateral3.structure.*;

@:build(hx.doctest.DocTestGenerator.generateDocTests())
@:build(utest.utils.TestBuilder.build())
class TestTrilateral3 extends utest.Test {
    public static function main() {
        var runner = new Runner();
        runner.addCase( new TestTrilateral3() );
        Report.create(runner);
        runner.run();
    }
    function new() {
        super();
    }
}
#end