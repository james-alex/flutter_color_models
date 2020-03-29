import 'package:flutter/material.dart' show Color;
import 'package:color_models/color_models.dart' as cm;
import '../color_model.dart';
import '../helpers/to_color.dart';

/// A color in the HSV (HSB) color space.
///
/// The HSV color space contains channels for [hue],
/// [saturation], and [value].
class HsvColor extends cm.HsvColor with ToColor {
  /// A color in the HSV (HSB) color space.
  ///
  /// [hue] must be `>= 0` and `<= 360`.
  ///
  /// [saturation] and [value] must both be `>= 0` and `<= 100`.
  const HsvColor(
    num hue,
    num saturation,
    num value, [
    num alpha = 1.0,
  ])  : assert(hue != null && hue >= 0 && hue <= 360),
        assert(saturation != null && saturation >= 0 && saturation <= 100),
        assert(value != null && value >= 0 && value <= 100),
        assert(alpha != null && alpha >= 0 && alpha <= 1),
        super(hue, saturation, value, alpha);

  @override
  List<HsvColor> interpolateTo(
    ColorModel color,
    int steps, {
    bool excludeOriginalColors = false,
  }) {
    assert(color != null);
    assert(steps != null && steps > 0);
    assert(excludeOriginalColors != null);

    final colors = ToColor.cast(this).interpolateTo(ToColor.cast(color), steps,
        excludeOriginalColors: excludeOriginalColors);

    return List<HsvColor>.from(colors.map(ToColor.cast));
  }

  @override
  HsvColor get inverted => ToColor.cast(ToColor.cast(this).inverted);

  @override
  HsvColor get opposite => rotateHue(180);

  @override
  HsvColor rotateHue(num amount) {
    assert(amount != null);

    final hslColor = toHslColor();

    return withHue((hslColor.hue + amount) % 360);
  }

  @override
  HsvColor warmer(num amount, {bool relative = true}) {
    assert(amount != null && amount > 0);
    assert(relative != null);

    return ToColor.cast(ToColor.cast(this).warmer(amount, relative: relative));
  }

  @override
  HsvColor cooler(num amount, {bool relative = true}) {
    assert(amount != null && amount > 0);
    assert(relative != null);

    return ToColor.cast(ToColor.cast(this).cooler(amount, relative: relative));
  }

  @override
  HsvColor withHue(num hue) {
    assert(hue != null && hue >= 0 && hue <= 360);

    return HsvColor(hue, saturation, value, alpha);
  }

  @override
  HsvColor withSaturation(num saturation) {
    assert(saturation != null && saturation >= 0 && saturation <= 100);

    return HsvColor(hue, saturation, value, alpha);
  }

  @override
  HsvColor withValue(num value) {
    assert(value != null && value >= 0 && value <= 100);

    return HsvColor(hue, saturation, value, alpha);
  }

  @override
  HsvColor withAlpha(num alpha) {
    assert(alpha != null && alpha >= 0 && alpha <= 1);

    return HsvColor(hue, saturation, value, alpha);
  }

  @override
  HsvColor toHsvColor() => this;

  /// Constructs a [HsvColor] from [color].
  factory HsvColor.from(ColorModel color) {
    assert(color != null);

    color = ToColor.cast(color);

    final hsv = cm.ColorConverter.toHsvColor(color);

    return HsvColor(hsv.hue, hsv.saturation, hsv.value);
  }

  /// Constructs a [HsvColor] from a list of [hsv] values.
  ///
  /// [hsv] must not be null and must have exactly `3` or `4` values.
  ///
  /// The hue must be `>= 0` and `<= 360`.
  ///
  /// The saturation and value must both be `>= 0` and `<= 100`.
  factory HsvColor.fromList(List<num> hsv) {
    assert(hsv != null && (hsv.length == 3 || hsv.length == 4));
    assert(hsv[0] != null && hsv[0] >= 0 && hsv[0] <= 360);
    assert(hsv[1] != null && hsv[1] >= 0 && hsv[1] <= 100);
    assert(hsv[2] != null && hsv[2] >= 0 && hsv[2] <= 100);
    if (hsv.length == 4) {
      assert(hsv[3] != null && hsv[3] >= 0 && hsv[3] <= 1);
    }

    final alpha = hsv.length == 4 ? hsv[3] : 1.0;

    return HsvColor(hsv[0], hsv[1], hsv[2], alpha);
  }

  /// Constructs a [HslColor] from [color].
  factory HsvColor.fromColor(Color color) {
    assert(color != null);

    return RgbColor.fromColor(color).toHsvColor();
  }

  /// Constructs a [HsvColor] from a [hex] color.
  ///
  /// [hex] is case-insensitive and must be `3` or `6` characters
  /// in length, excluding an optional leading `#`.
  factory HsvColor.fromHex(String hex) {
    assert(hex != null);

    final hsv = cm.HsvColor.fromHex(hex);

    return HsvColor(hsv.hue, hsv.saturation, hsv.value);
  }

  /// Constructs a [HsvColor] from a list of [hsv] values on a `0` to `1` scale.
  ///
  /// [hsv] must not be null and must have exactly `3` or `4` values.
  ///
  /// Each of the values must be `>= 0` and `<= 1`.
  factory HsvColor.extrapolate(List<double> hsv) {
    assert(hsv != null && (hsv.length == 3 || hsv.length == 4));
    assert(hsv[0] != null && hsv[0] >= 0 && hsv[0] <= 1);
    assert(hsv[1] != null && hsv[1] >= 0 && hsv[1] <= 1);
    assert(hsv[2] != null && hsv[2] >= 0 && hsv[2] <= 1);
    if (hsv.length == 4) {
      assert(hsv[3] != null && hsv[3] >= 0 && hsv[3] <= 1);
    }

    final alpha = hsv.length == 4 ? hsv[3] : 1.0;

    return HsvColor(hsv[0] * 360, hsv[1] * 100, hsv[2] * 100, alpha);
  }

  /// Generates a [HsvColor] at random.
  ///
  /// [minHue] and [maxHue] constrain the generated [hue] value. If
  /// `minHue < maxHue`, the range will run in a clockwise direction
  /// between the two, however if `minHue > maxHue`, the range will
  /// run in a counter-clockwise direction. Both [minHue] and [maxHue]
  /// must be `>= 0 && <= 360` and must not be `null`.
  ///
  /// [minSaturation] and [maxSaturation] constrain the generated [saturation]
  /// value.
  ///
  /// [minValue] and [maxValue] constrain the generated [value] value.
  ///
  /// Min and max values, besides hues, must be `min <= max && max >= min`,
  /// must be in the range of `>= 0 && <= 100`, and must not be `null`.
  factory HsvColor.random({
    num minHue = 0,
    num maxHue = 360,
    num minSaturation = 0,
    num maxSaturation = 100,
    num minValue = 0,
    num maxValue = 100,
  }) {
    assert(minHue != null && minHue >= 0 && minHue <= 360);
    assert(maxHue != null && maxHue >= 0 && maxHue <= 360);
    assert(minSaturation != null &&
        minSaturation >= 0 &&
        minSaturation <= maxSaturation);
    assert(maxSaturation != null &&
        maxSaturation >= minSaturation &&
        maxSaturation <= 100);
    assert(minValue != null && minValue >= 0 && minValue <= maxValue);
    assert(maxValue != null && maxValue >= minValue && maxValue <= 100);

    return ToColor.cast(cm.HsvColor.random(
      minHue: minHue,
      maxHue: maxHue,
      minSaturation: minSaturation,
      maxSaturation: maxSaturation,
      minValue: minValue,
      maxValue: maxValue,
    ));
  }
}
