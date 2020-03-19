import 'package:flutter/material.dart' show Color;
import 'package:color_models/color_models.dart' as cm;
import '../color_model.dart';
import './helpers/to_color.dart';

/// A color in the sRGB color space.
///
/// The sRGB color space contains channels for [red], [green], and [blue].
///
/// [RgbColor] stores RGB values as [num]s privately in order to avoid
/// a loss of precision when converting between color spaces, but has
/// getters set for [red], [green], and [blue] that return the rounded
/// [int] values. The precise values can returned as a list with the
/// `toPreciseList()` method.
class RgbColor extends cm.RgbColor with ToColor {
  /// A color in the sRGB color space.
  ///
  /// [_red], [_green], and [_blue] must all be `>= 0` and `<= 255`.
  const RgbColor(
    num red,
    num green,
    num blue, [
    num alpha = 1.0,
  ]) :  assert(red != null && red >= 0 && red <= 255),
        assert(green != null && green >= 0 && green <= 255),
        assert(blue != null && blue >= 0 && green <= 255),
        assert(alpha != null && alpha >= 0 && alpha <= 1),
        super(red, green, blue, alpha);

  @override
  RgbColor withRed(num red) {
    assert(red != null && red >= 0 && red <= 255);

    return RgbColor(red, green, blue, alpha);
  }

  @override
  RgbColor withGreen(num green) {
    assert(green != null && green >= 0 && green <= 255);

    return RgbColor(red, green, blue, alpha);
  }

  @override
  RgbColor withBlue(num blue) {
    assert(blue != null && blue >= 0 && blue <= 255);

    return RgbColor(red, green, blue, alpha);
  }

  @override
  RgbColor withAlpha(num alpha) {
    assert(alpha != null && alpha >= 0 && alpha <= 1);

    return RgbColor(red, green, blue, alpha);
  }

  /// Parses a list for RGB values and returns a [RgbColor].
  ///
  /// [rgb] must not be null and must have exactly `3` or `4` values.
  ///
  /// Each color value must be `>= 0 && <= 255`.
  static RgbColor fromList(List<num> rgb) {
    assert(rgb != null && (rgb.length == 3 || rgb.length == 4));
    assert(rgb[0] != null && rgb[0] >= 0 && rgb[0] <= 255);
    assert(rgb[1] != null && rgb[1] >= 0 && rgb[1] <= 255);
    assert(rgb[2] != null && rgb[2] >= 0 && rgb[2] <= 255);
    if (rgb.length == 4) {
      assert(rgb[3] != null && rgb[3] >= 0 && rgb[3] <= 1);
    }

    final alpha = rgb.length == 4 ? rgb[3] : 1.0;

    return RgbColor(rgb[0], rgb[1], rgb[2], alpha);
  }

  /// Returns [color] as a [RgbColor].
  static RgbColor fromColor(Color color) {
    assert(color != null);

    return RgbColor(color.red, color.green, color.blue);
  }

  /// Returns a [color] in another color space as a RGB color.
  static RgbColor from(ColorModel color) {
    assert(color != null);

    color = ToColor.cast(color);

    final rgb = color.toRgbColor();

    return RgbColor(rgb.red, rgb.green, rgb.blue);
  }

  /// Returns a [hex] color as a RGB color.
  ///
  /// [hex] is case-insensitive and must be `3` or `6` characters
  /// in length, excluding an optional leading `#`.
  static RgbColor fromHex(String hex) {
    assert(hex != null);

    final rgb = cm.RgbColor.fromHex(hex);

    return RgbColor(rgb.red, rgb.green, rgb.blue);
  }

  /// Returns a [RgbColor] from a list of [rgb] values on a 0 to 1 scale.
  ///
  /// [rgb] must not be null and must have exactly `3` or `4` values.
  ///
  /// Each of the values must be `>= 0` and `<= 1`.
  static RgbColor extrapolate(List<double> rgb) {
    assert(rgb != null && (rgb.length == 3 || rgb.length == 4));
    assert(rgb[0] != null && rgb[0] >= 0 && rgb[0] <= 1);
    assert(rgb[1] != null && rgb[1] >= 0 && rgb[1] <= 1);
    assert(rgb[2] != null && rgb[2] >= 0 && rgb[2] <= 1);
    if (rgb.length == 4) {
      assert(rgb[3] != null && rgb[3] >= 0 && rgb[3] <= 1);
    }

    final alpha = rgb.length == 4 ? rgb[3] : 1.0;

    return RgbColor(rgb[0] * 255, rgb[1] * 255, rgb[2] * 255, alpha);
  }
}
