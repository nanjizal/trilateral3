# trilateral3 

Haxe 2D drawing engine suitable for use with GPU, ideal for use on WebGL but can be used with other haxe toolkits and libraries to also target c++.

## Library dependancies

- [hyperKitGL](https://github.com/nanjizal/hyperKitGL), optional library for use with WebGL alternatively [kitGL](https://github.com/nanjizal/kitGL) and [dsHelper](https://github.com/nanjizal/dsHelper) can be used instead.

- [fracs](https://github.com/nanjizal/fracs), Fast Decimal to Fraction Approximations for Haxe, used mostly for simplifying rotations, potentially could be factored out.

- [justPath](https://github.com/nanjizal/justPath), justPath is quick parsing of a string from an svg path.

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

- [For WebGL use hyperKitGL](https://github.com/nanjizal/hyperKitGL#hyperkitgl)

- example WIP use cases are contained on [TrilateralX](https://github.com/TrilateralX)

- **target** folder to ease toolkits was moved to seperate repo to avoid **dox** issues.

