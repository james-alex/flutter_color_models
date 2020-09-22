import 'package:flutter/painting.dart' show Color;
import 'package:color_models/color_models.dart' as cm;
import '../../color_model.dart';
import 'cast_to_color.dart' as ctc;

/// Mixes in methods to convert a color to any other color model.
mixin ToColor on ColorModel {
  @override
  bool equals(ColorModel color) {
    assert(color != null);

    return (RgbColor.from(this) == RgbColor.from(color));
  }

  /// Returns `this` as a [Color], converting the model to RGB if necessary.
  Color toColor() => ctc.toColor(this);

  /// Converts `this` to the CMYK color space.
  @override
  CmykColor toCmykColor() => CmykColor.from(this);

  /// Converts `this` to the HSI color space.
  @override
  HsiColor toHsiColor() => HsiColor.from(this);

  /// Converts `this` to the HSL color space.
  @override
  HslColor toHslColor() => HslColor.from(this);

  /// Converts `this` to the HSP color space.
  @override
  HspColor toHspColor() => HspColor.from(this);

  /// Converts `this` to the HSV color space.
  @override
  HsbColor toHsbColor() => HsbColor.from(this);

  /// Converts `this` to the LAB color space.
  @override
  LabColor toLabColor() => LabColor.from(this);

  /// Converts `this` to the RGB color space.
  @override
  RgbColor toRgbColor() => RgbColor.from(this);

  /// Converts `this` to the XYZ color space.
  @override
  XyzColor toXyzColor() => XyzColor.from(this);

  /// Casts [ColorModel]s to and from this package's models
  /// and the color_model package's models.
  static ColorModel cast(ColorModel color) {
    assert(color != null);

    switch (color.runtimeType) {
      case CmykColor:
        color = cm.CmykColor.fromList(color.toListWithAlpha());
        break;
      case HsiColor:
        color = cm.HsiColor.fromList(color.toListWithAlpha());
        break;
      case HslColor:
        color = cm.HslColor.fromList(color.toListWithAlpha());
        break;
      case HspColor:
        color = cm.HspColor.fromList(color.toListWithAlpha());
        break;
      case HsbColor:
        color = cm.HsbColor.fromList(color.toListWithAlpha());
        break;
      case LabColor:
        color = cm.LabColor.fromList(color.toListWithAlpha());
        break;
      case RgbColor:
        color =
            cm.RgbColor.fromList((color as RgbColor).toPreciseListWithAlpha());
        break;
      case XyzColor:
        color = cm.XyzColor.fromList(color.toListWithAlpha());
        break;
      case cm.CmykColor:
        color = CmykColor.fromList(color.toListWithAlpha());
        break;
      case cm.HsiColor:
        color = HsiColor.fromList(color.toListWithAlpha());
        break;
      case cm.HslColor:
        color = HslColor.fromList(color.toListWithAlpha());
        break;
      case cm.HspColor:
        color = HspColor.fromList(color.toListWithAlpha());
        break;
      case cm.HsbColor:
        color = HsbColor.fromList(color.toListWithAlpha());
        break;
      case cm.LabColor:
        color = LabColor.fromList(color.toListWithAlpha());
        break;
      case cm.RgbColor:
        color =
            RgbColor.fromList((color as cm.RgbColor).toPreciseListWithAlpha());
        break;
      case cm.XyzColor:
        color = XyzColor.fromList(color.toListWithAlpha());
        break;
    }

    return color;
  }
}
