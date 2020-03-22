import 'package:flutter/material.dart' show Color;
import 'package:color_models/color_models.dart' as cm;
import '../color_model.dart';
import '../helpers/to_color.dart';

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
  ])  : assert(red != null && red >= 0 && red <= 255),
        assert(green != null && green >= 0 && green <= 255),
        assert(blue != null && blue >= 0 && green <= 255),
        assert(alpha != null && alpha >= 0 && alpha <= 1),
        super(red, green, blue, alpha);

  @override
  RgbColor get inverted => ToColor.cast(ToColor.cast(this).inverted);

  @override
  RgbColor get opposite => rotateHue(180);

  @override
  RgbColor rotateHue(num amount) {
    assert(amount != null);

    final hslColor = toHslColor();

    return hslColor.withHue((hslColor.hue + amount) % 360).toRgbColor();
  }

  @override
  RgbColor warmer(num amount) {
    assert(amount != null && amount > 0);

    return ToColor.cast(ToColor.cast(this).warmer(amount));
  }

  @override
  RgbColor cooler(num amount) {
    assert(amount != null && amount > 0);

    return ToColor.cast(ToColor.cast(this).cooler(amount));
  }

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

  /// Returns this [RgbColor] modified with the provided [hue] value.
  @override
  RgbColor withHue(num hue) {
    assert(hue != null && hue >= 0 && hue <= 360);

    final hslColor = toHslColor();

    return hslColor.withHue((hslColor.hue + hue) % 360).toRgbColor();
  }

  /// Constructs a [RgbColor] from [color].
  factory RgbColor.from(ColorModel color) {
    assert(color != null);

    color = ToColor.cast(color);

    final rgb = color.toRgbColor();

    return RgbColor(rgb.red, rgb.green, rgb.blue);
  }

  /// Constructs a [RgbColor] from a list of [rgb] values.
  ///
  /// [rgb] must not be null and must have exactly `3` or `4` values.
  ///
  /// Each color value must be `>= 0 && <= 255`.
  factory RgbColor.fromList(List<num> rgb) {
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

  /// Constructs a [RgbColor] from [color].
  factory RgbColor.fromColor(Color color) {
    assert(color != null);

    return RgbColor(color.red, color.green, color.blue);
  }

  /// Constructs a [RgbColor] from a [hex] color.
  ///
  /// [hex] is case-insensitive and must be `3` or `6` characters
  /// in length, excluding an optional leading `#`.
  factory RgbColor.fromHex(String hex) {
    assert(hex != null);

    final rgb = cm.RgbColor.fromHex(hex);

    return RgbColor(rgb.red, rgb.green, rgb.blue);
  }

  /// Constructs a [RgbColor] from a list of [rgb] values on a `0` to `1` scale.
  ///
  /// [rgb] must not be null and must have exactly `3` or `4` values.
  ///
  /// Each of the values must be `>= 0` and `<= 1`.
  factory RgbColor.extrapolate(List<double> rgb) {
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
