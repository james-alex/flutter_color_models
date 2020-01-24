# flutter_color_models

[![pub package](https://img.shields.io/pub/v/flutter_color_models.svg)](https://pub.dartlang.org/packages/flutter_color_models)
[![style: effective dart](https://img.shields.io/badge/style-effective_dart-40c4ff.svg)](https://github.com/tenhobi/effective_dart)

A wrapper for the color_models plugin with added
support for Flutter's [Color] class.

See: https://pub.dev/packages/color_models

## Usage

```dart
import 'package:flutter_color_models/flutter_color_models.dart';
```

## Color Spaces

color_models exposes models for the CMYK, HSI, HSL, HSP, HSV, LAB, RGB,
and XYZ color spaces; represented as [CmykColor], [HsiColor], [HslColor],
[HspColor], [HsvColor], [LabColor], [RgbColor], and [XyzColor] respectively.

Each model is constant and extends [ColorModel].

## Casting Color to and from the ColorModels

Each color model has method `toColor()` a static method `fromColor()`
that will recast a [Color] to a [ColorModel] and vice versa, converting
the color to desired color space if not called on [RgbColor].

```dart
Color color = Color(0xFFFFFF00); // yellow

CmykColor cmykColor = CmykColor.fromColor(color);
color = cmykColor.toColor();

HsiColor hsiColor = HsiColor.fromColor(color);
color = hsiColor.toColor();

HslColor hslColor = HslColor.fromColor(color);
color = hslColor.toColor();

HspColor hspColor = HspColor.fromColor(color);
color = hspColor.toColor();

HsvColor hsvColor = HsvColor.fromColor(color);
color = hsvColor.toColor();

LabColor labColor = LabColor.fromColor(color);
color = labColor.toColor();

RgbColor rgbColor = RgbColor.fromColor(color);
color = rgbColor.toColor();

XyzColor xyzColor = XyzColor.fromColor(color);
color = xyzColor.toColor();
```

## Converting Colors Between Spaces

Each color model has methods to convert itself
to each of the other color models.

```dart
CmykColor toCmykColor();

HsiColor toHsiColor();

HslColor toHslColor();

HspColor toHspColor();

HsvColor toHsvColor();

LabColor toLabColor();

RgbColor toRgbColor();

XyzColor toXyzColor();
```

Altenatively, each color model has a static method `from` that can
accept a color from any color space and returns its own type (T).

```dart
static T from(ColorModel color);
```

```dart
// Create a HSV color
HsvColor originalColor = HsvColor(0.3, 0.8, 0.7);

// Convert it to RGB => RgbColor(64, 179, 36)
RgbColor rgbColor = RgbColor.from(originalColor);

// Then to CMYK => CmykColor(64.25, 0, 79.89, 29.8)
CmykColor cmykColor = CmykColor.from(rgbColor);

// Back to HSV => HsvColor(0.3, 0.8, 0.7)
HsvColor hsvColor = HsvColor.from(cmykColor);
```

__Note:__ All color conversions use the RGB color space as an
intermediary. To minimize the loss of precision when converting
between other color spaces, [RgbColor] privately stores the RGB
values as [num]s rather than [int]s. The [num] values can be
returned as a list with [RgbColor]'s `toPreciseList()` method.
