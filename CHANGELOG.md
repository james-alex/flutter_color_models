## [0.1.6] - March 29, 2020

* Added the [interpolateTo] method to each color model.

* Override the conversion methods on each color model that return their own
respective color spaces. Colors were being unnecessarily converted back and
forth from RGB.

## [0.1.5+1] - March 27, 2020

* Added the global [toColor] method.

## [0.1.5] - March 24, 2020

* Added the random factory constructor to each [ColorModel].

* The equality operator and some getters now rounds values to the millionth due
to the slight loss of precision during conversions.

* The [hue] getter now calculates hues directly from RGB,
rather than doing a full conversion to HSL.

* Added the [isMonochromatic] getter to each [ColorModel].

## [0.1.4+1] - March 23, 2020

* Fixed a bug and corrected rounding errors in HSP to RGB conversion.

## [0.1.4] - March 22, 2020

* Added the [relative] parameter to the [warmer] and [cooler] methods.

## [0.1.3+2] - March 22, 2020

* Added the [saturation] getter to [ColorModel].

## [0.1.3+1] - March 22, 2020

* Added the [hue] getter to [ColorModel].

## [0.1.3] - March 21, 2020

* Added the [inverted] and [opposite] getters, as well as the [warmer],
[cooler], [rotateHue], and [withHue] methods to each [ColorModel].

## [0.1.2] - March 18, 2020

* Added support for [alpha] values and related methods to each of the [ColorModel]s.

## [0.1.1+1] - March 17, 2020

* Updated the color_models package to version 0.2.2+3.

## [0.1.1] - March 16, 2020

* Updated the color_models package to version 0.2.2+2.

* Added the [fromHex] static method to each of the [ColorModel]s.

## [0.1.0+2] - January 15, 2019

* Updated the color_models package to version 0.2.1+2.

* Documentation and formatting changes.

## [0.1.0] - July 23, 2019

* Initial release
