# trilateral3 

Haxe 2D drawing engine suitable for use with GPU, ideal for use on WebGL but can be used with other haxe toolkits and libraries to also target c++.

## Library dependancies

- [hyperKitGL](https://github.com/nanjizal/hyperKitGL), optional library for use with WebGL alternatively [kitGL](https://github.com/nanjizal/kitGL) and [dsHelper](https://github.com/nanjizal/dsHelper) can be used instead.

- [fracs](https://github.com/nanjizal/fracs), Fast Decimal to Fraction Approximations for Haxe, used mostly for simplifying rotations, potentially could be factored out.

- [justPath](https://github.com/nanjizal/justPath), justPath is quick parsing of a string from an svg path.

-[cornerContour](https://github.com/nanjzial/cornerContour), cornerContour provides the algorithm for drawing thick lines with possibly nice rounded corners.

## Libraries likely to be needed.

-  **Triangulate libraries**, need for fill, and all have specific advantages, [hxPolyK](https://github.com/nanjizal/hxPolyK),  [hxGeomAlgo](https://github.com/azrafe7/hxGeomAlgo), [poly2trihx](https://github.com/nerik/poly2trihx)

 - [geom](https://github.com/nanjizal/geom), matrix/vector optional library not actually required, as minimal matrix implemention built in, but wired for normal use via a **-D** flag.
 
- [pallette](https://github.com/nanjizal/pallette), setup to provide helpers for colors.

## Additional libraries very useful.

- [hxPixels](https://github.com/azrafe7/hxPixels) useful for pixel drawing and manipulation.

- [hxDaedalus](https://github.com/hxDaedalus/hxDaedalus) useful for pathfinding.

- [gluon](https://github.com/haxiomic/gluon) and [linc_glfw](https://github.com/Sunjammer/linc_glfw) for direct OpenGL.

- [hxRectPack2D](https://github.com/nanjizal/hxRectPack2D) useful for atlas / and texturepacking.

## notes

- [trilateral3 API code documentation](https://nanjizal.github.io/trilateral3/pages/)

- For WebGL use [hyperKitGL](https://github.com/nanjizal/hyperKitGL#hyperkitgl) the default version.

- example WIP use cases are contained on [TrilateralX](https://github.com/TrilateralX)

- [0.0.4-alpha](https://github.com/nanjizal/trilateral3/releases/tag/0.0.4-alpha) pre-release zip.

- **target** folder to easy toolkits use, have been moved to seperate repo to avoid **dox** issues. The issues with the toolkits were due to not being always well formed for **dox** or out of phase with latest haxe builds.

- currently setup for 1000x1000 pixels, this can be changed in theory, but cost of inverting scales, mostly tested on mac retina may need more testing elsewhere but mostly isolated from the actual shader implementation details.

- the abstraction allow many shader setups, but it may make sense to remove the abstractions for speed and include more of the shader implementation.

- **MatrixDozen** only provides matrix muliplication, really should use **geom** library with trilateral3 if you want to do real transformations and complex animations.

- examples currently only use a single texture and don't have any draw to image then screen examples, scaling is currently setup for only one texture. With various toolkits it maybe easier to rely on them for this feature.

- toolkits, originally the concept was developed in haxe flash, then evolved to support all toolkits ( Luxe, Nme, Openfl, Kha, Heaps, Canvas, Flash, WebGL ). In early versions the most extensive examples used Kha, but in trilateral3 the focus has been on WebGL direct, with color only tests with Gluon/Glut, NME, Lime and less optimally other toolkits.

- The concept is to use low level **Contour** to provide basic curve drawing with optional smooth joins, drawing to abstract type structures above Float32Array buffer, with a triangle pointer to allow easy update. Examples include mix of Color and Texture.

- For drawing texture apply the unit transform as required, draw shape above the texture you need and then reshape properties to required position, uv and colors.


