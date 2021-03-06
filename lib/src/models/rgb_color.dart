import 'package:flutter/painting.dart' show Color;
import 'package:color_models/color_models.dart' as cm;
import '../color_model.dart';
import 'helpers/as_color.dart';
import 'helpers/to_color.dart';

/// A color in the sRGB color space.
///
/// The sRGB color space contains channels for [red], [green], and [blue].
///
/// [RgbColor] stores RGB values as [num]s privately in order to avoid
/// a loss of precision when converting between color spaces, but has
/// getters set for [red], [green], and [blue] that return the rounded
/// [int] values. The precise values can returned as a list with the
/// [toPreciseList] and [toPreciseListWithAlpha] methods.
class RgbColor extends cm.RgbColor with AsColor, ToColor implements ColorModel {
  /// A color in the sRGB color space.
  ///
  /// [_red], [_green], and [_blue] must all be `>= 0` and `<= 255`.
  const RgbColor(
    num red,
    num green,
    num blue, [
    int alpha = 255,
  ])  : assert(red != null && red >= 0 && red <= 255),
        assert(green != null && green >= 0 && green <= 255),
        assert(blue != null && blue >= 0 && green <= 255),
        assert(alpha != null && alpha >= 0 && alpha <= 255),
        super(red, green, blue, alpha);

  @override
  int get value => toColor().value;

  @override
  List<RgbColor> lerpTo(
    cm.ColorModel color,
    int steps, {
    bool excludeOriginalColors = false,
  }) {
    assert(color != null);
    assert(steps != null && steps > 0);
    assert(excludeOriginalColors != null);

    final colors = ToColor.cast(this).lerpTo(ToColor.cast(color), steps,
        excludeOriginalColors: excludeOriginalColors);

    return List<RgbColor>.from(colors.map(ToColor.cast));
  }

  @override
  RgbColor get inverted => ToColor.cast(super.inverted);

  @override
  RgbColor get opposite => rotateHue(180);

  @override
  RgbColor rotateHue(num amount) {
    assert(amount != null);

    return ToColor.cast(ToColor.cast(this).rotateHue(amount));
  }

  @override
  RgbColor warmer(num amount, {bool relative = true}) {
    assert(amount != null && amount > 0);
    assert(relative != null);

    return ToColor.cast(ToColor.cast(this).warmer(amount, relative: relative));
  }

  @override
  RgbColor cooler(num amount, {bool relative = true}) {
    assert(amount != null && amount > 0);
    assert(relative != null);

    return ToColor.cast(ToColor.cast(this).cooler(amount, relative: relative));
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
  RgbColor withAlpha(int alpha) {
    assert(alpha != null && alpha >= 0 && alpha <= 255);

    return RgbColor(red, green, blue, alpha);
  }

  @override
  RgbColor withOpacity(double opacity) {
    assert(opacity != null && opacity >= 0.0 && opacity <= 1.0);

    return withAlpha((opacity * 255).round());
  }

  /// Returns this [RgbColor] modified with the provided [hue] value.
  @override
  RgbColor withHue(num hue) {
    assert(hue != null && hue >= 0 && hue <= 360);

    final hslColor = toHslColor();

    return hslColor.withHue((hslColor.hue + hue) % 360).toRgbColor();
  }

  @override
  RgbColor toRgbColor() => this;

  /// Constructs a [RgbColor] from [color].
  factory RgbColor.from(cm.ColorModel color) {
    assert(color != null);

    color = ToColor.cast(color);

    final rgb = color.toRgbColor();

    return RgbColor(rgb.red, rgb.green, rgb.blue, rgb.alpha);
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
      assert(rgb[3] != null && rgb[3] >= 0 && rgb[3] <= 255);
    }

    final alpha = rgb.length == 4 ? rgb[3].round() : 255;

    return RgbColor(rgb[0], rgb[1], rgb[2], alpha);
  }

  /// Constructs a [RgbColor] from [color].
  factory RgbColor.fromColor(Color color) {
    assert(color != null);

    return RgbColor(color.red, color.green, color.blue, color.alpha);
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

    final alpha = rgb.length == 4 ? (rgb[3] * 255).round() : 255;

    return RgbColor(rgb[0] * 255, rgb[1] * 255, rgb[2] * 255, alpha);
  }

  /// Generates a [RgbColor] at random.
  ///
  /// [minRed] and [maxRed] constrain the generated [red] value.
  ///
  /// [minGreen] and [maxGreen] constrain the generated [green] value.
  ///
  /// [minBlue] and [maxBlue] constrain the generated [blue] value.
  ///
  /// All min and max values must be `min <= max && max >= min` and
  /// must be in the range of `>= 0 && <= 255`.
  factory RgbColor.random({
    int minRed = 0,
    int maxRed = 255,
    int minGreen = 0,
    int maxGreen = 255,
    int minBlue = 0,
    int maxBlue = 255,
  }) {
    assert(minRed != null && minRed >= 0 && minRed <= maxRed);
    assert(maxRed != null && maxRed >= minRed && maxRed <= 255);
    assert(minGreen != null && minGreen >= 0 && minGreen <= maxGreen);
    assert(maxGreen != null && maxGreen >= minGreen && maxGreen <= 255);
    assert(minBlue != null && minBlue >= 0 && minBlue <= maxBlue);
    assert(maxBlue != null && maxBlue >= minBlue && maxBlue <= 255);

    return ToColor.cast(cm.RgbColor.random(
      minRed: minRed,
      maxRed: maxRed,
      minGreen: minGreen,
      maxGreen: maxGreen,
      minBlue: minBlue,
      maxBlue: maxBlue,
    ));
  }
}
