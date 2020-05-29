# trilateral3 
### Requires Haxe 4.2 or greater

Low-level GPU triangle drawing engine core.

[trilateral3 dox](https://nanjizal.github.io/trilateral3/pages/)

### Dependencies
trilateral3 is written in 100% Haxe and uses a range of helper libraries to complement the basics. No macros are used, but Abstract and Module-level functions are used extensively.

**trilateral3** has some dependencies and optional dependencies:
- trilateral3.geom.* requires dsHelper to provide Float32Array abstracts. It's possible to implement your own functionality for DrawAbstract and ColorAbstract, and you're not constrained to storing data in Arrays, but it is easier to wire them to a shader by calling toArray.
- fracs is currently required for angle calculations.
- trilateral3.drawing.fill requires the algorithm libraries hxPolyK, poly2trihx, and hxGeomAlgo. If you don't use fills you may not need these installed.
- trilateral3.matrix.* can optionally be used with geom math library, but should be feasible to use with hxMath instead, or without any math library. I may look into providing an example in the future with hxMath.
- pallette is likely a dependancy. It only provides colors, so I may try to make it optional in the future.
- justPath is used for SVG path drawing and is likely optional.

To quickly setup trilateral3, install kitGL to help with WebGL or Lime setup, it also provides some helpers for general javascript use. This engine can be used with OpenGL or any system that draws triangles with the GPU.

Currently, a simple WebGL example can be found at (http://www.github.com/nanjizal/trilateral3Minimal). You can find an hxml script to help install the required dependdncies from github.

### Usage

#### Pen, Sketch and Regular

The standard workflow is to create a Pen with AbstractDraw and AbstractColor implementations, typically via an abstract around a Float32Array or possibly Int16Array, but you're free to swap to a different storage. An ideal approach is to use the FlatColorTriangles class for both AbstractDraw and AbstractColor (see the minimal example of typical setup, it's a bit ugly but allows flexibility for different shader setups).

Once you have a pen, you can use Shaper to create shapes. They return an index of vertices and that is used to add color.

Alternatively, you can pass the Pen to Sketch, allowing you to use regular line and curve draw commands or even Svg paths.  

Regular extends Sketch and is an easy way to create RegularShapes. It returns an IndexRange you can keep to extract the shapes later to transform or re-color.

Typical drawing code might look like this...:

``` haxe
pen.width = 10;
sketch.moveTo( x0, y0 );
sketch.lineTo( x1, y1 );
sketch.cuveThru( x3, y3, x4, y4 );
```

...although it's often easier to feed it an SVG path as a string.

#### Styles

Contours can be drawn with few triangles, or many. The StyleSketch currently determines if the corners between lines are smooth, just a triangle, or just overlapping rectangles. For simple shapes you can obviously use Shaper or Regular for outlines or fills. To draw and fill a Contour, you must use two StyleSketch, a Fill, and one other.

StyleEndLine is used to define whether Sketch ends line drawings with rounded or blunt ends.

StyleFill is used to determine the Fill style used.

#### Transforms

The default Abstract Float32Array can have transforms applied over the whole drawing or to specific IndexRanges.

The matrix and vector math internally is very minimal, but can easily be setup to use geom or similar math libraries so you can do fancy stuff like control shapes in 3D. This can be done on the abstract Float32Array or on the matrix passed to the Shader.

### Supported Toolkits

Currently, the original Trilateral provided examples in OpenFL/NME, Heaps, WebGL, Canvas, SVG, Kha graphics2 or graphics4, and Armory3D Iron.

Trilateral3 provides bare bones for WebGL. Using kitGL you can easily setup a similar Lime example and the helpers are all mirrored, and as before it should be very easy to use with Kha and largely concepted against Kha. Currently there has been no progress with low level Heaps support; assistance would be ideal, but if speed is not vital you can just pass the arrays to a drawTriangle function.

### Textures and Gradients

The orginal Trilateral has Texture support and a way to use Gradients it requires two draws. Trilateral3 does not yet have details finalized, but does provide an angular gradient for circles which could be extended and is possible to use as a 3 color gradient on a circle. Essentially, for texture uv coordinates based on the xy positions can be passed, they just require a different transform ( 0 -> 1 rather than -1 -> 1 ) and may require some tweaking of TRIANGLE corner order.

### 2.5D

With hxMath or geom it is easy to draw 2D shapes in 3D. You can either transform them via the abstract Float32Array structures or via a Shader matrix.

### Font and Extruded Shapes

Drawing text with Trilateral3 is possible, but it quickly takes up a lot of triangles so these should be drawn to an intermediate texture to reduce overhead. Ideally each letter would then be drawn to screen with two triangles. There are some tests of this concept on my repo.

### Lots of Triangles

Trilateral3 in fine mode uses excessive amounts of triangles, so it is best to watch your needs and draw to intermediate textures if needed. kitGL provides a class called texture which has some basic canvas draw commands and the gl context, but it also has drawImage to help with drawing between 'textures.' Textures needs renaming.

### Trilateral versus Trilateral3
The structure is significantly improved, but Trilateral has more examples with texture, fxg, alpha etc. The base is there and more examples can be added over time.
