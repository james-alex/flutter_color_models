import 'package:flutter/painting.dart' show Color;
import 'package:color_models/color_models.dart' as cm;
import '../color_model.dart';
import 'helpers/as_color.dart';
import 'helpers/rgb_getters.dart';
import 'helpers/to_color.dart';

/// A color in the HSB (HSB) color space.
///
/// The HSB color space contains channels for [hue],
/// [saturation], and [brightness].
class HsbColor extends cm.HsbColor
    with AsColor, RgbGetters, ToColor
    implements ColorModel {
  /// A color in the HSB (HSB) color space.
  ///
  /// [hue] must be `>= 0` and `<= 360`.
  ///
  /// [saturation] and [brightness] must both be `>= 0` and `<= 100`.
  const HsbColor(
    num hue,
    num saturation,
    num brightness, [
    int alpha = 255,
  ])  : assert(hue != null && hue >= 0 && hue <= 360),
        assert(saturation != null && saturation >= 0 && saturation <= 100),
        assert(brightness != null && brightness >= 0 && brightness <= 100),
        assert(alpha != null && alpha >= 0 && alpha <= 255),
        super(hue, saturation, brightness, alpha);

  @override
  int get value => toColor().value;

  @override
  List<HsbColor> lerpTo(
    cm.ColorModel color,
    int steps, {
    bool excludeOriginalColors = false,
  }) {
    assert(color != null);
    assert(steps != null && steps > 0);
    assert(excludeOriginalColors != null);

    final colors = ToColor.cast(this).lerpTo(ToColor.cast(color), steps,
        excludeOriginalColors: excludeOriginalColors);

    return List<HsbColor>.from(colors.map(ToColor.cast));
  }

  @override
  HsbColor get inverted => ToColor.cast(super.inverted);

  @override
  HsbColor get opposite => rotateHue(180);

  @override
  HsbColor rotateHue(num amount) {
    assert(amount != null);

    return ToColor.cast(ToColor.cast(this).rotateHue(amount));
  }

  @override
  HsbColor warmer(num amount, {bool relative = true}) {
    assert(amount != null && amount > 0);
    assert(relative != null);

    return ToColor.cast(ToColor.cast(this).warmer(amount, relative: relative));
  }

  @override
  HsbColor cooler(num amount, {bool relative = true}) {
    assert(amount != null && amount > 0);
    assert(relative != null);

    return ToColor.cast(ToColor.cast(this).cooler(amount, relative: relative));
  }

  @override
  HsbColor withHue(num hue) {
    assert(hue != null && hue >= 0 && hue <= 360);

    return HsbColor(hue, saturation, brightness, alpha);
  }

  @override
  HsbColor withSaturation(num saturation) {
    assert(saturation != null && saturation >= 0 && saturation <= 100);

    return HsbColor(hue, saturation, brightness, alpha);
  }

  @override
  HsbColor withBrightness(num brightness) {
    assert(brightness != null && brightness >= 0 && brightness <= 100);

    return HsbColor(hue, saturation, brightness, alpha);
  }

  @override
  HsbColor withRed(num red) {
    assert(red != null && red >= 0 && red <= 255);

    return toRgbColor().withRed(red).toHsbColor();
  }

  @override
  HsbColor withGreen(num green) {
    assert(green != null && green >= 0 && green <= 255);

    return toRgbColor().withGreen(green).toHsbColor();
  }

  @override
  HsbColor withBlue(num blue) {
    assert(blue != null && blue >= 0 && blue <= 255);

    return toRgbColor().withBlue(blue).toHsbColor();
  }

  @override
  HsbColor withAlpha(int alpha) {
    assert(alpha != null && alpha >= 0 && alpha <= 255);

    return HsbColor(hue, saturation, brightness, alpha);
  }

  @override
  HsbColor withOpacity(double opacity) {
    assert(opacity != null && opacity >= 0.0 && opacity <= 1.0);

    return withAlpha((opacity * 255).round());
  }

  @override
  HsbColor toHsbColor() => this;

  /// Constructs a [HsbColor] from [color].
  factory HsbColor.from(cm.ColorModel color) {
    assert(color != null);

    color = ToColor.cast(color);

    final hsb = cm.ColorConverter.toHsbColor(color);

    return HsbColor(hsb.hue, hsb.saturation, hsb.brightness, hsb.alpha);
  }

  /// Constructs a [HsbColor] from a list of [hsb] values.
  ///
  /// [hsb] must not be null and must have exactly `3` or `4` values.
  ///
  /// The hue must be `>= 0` and `<= 360`.
  ///
  /// The saturation and value must both be `>= 0` and `<= 100`.
  factory HsbColor.fromList(List<num> hsb) {
    assert(hsb != null && (hsb.length == 3 || hsb.length == 4));
    assert(hsb[0] != null && hsb[0] >= 0 && hsb[0] <= 360);
    assert(hsb[1] != null && hsb[1] >= 0 && hsb[1] <= 100);
    assert(hsb[2] != null && hsb[2] >= 0 && hsb[2] <= 100);
    if (hsb.length == 4) {
      assert(hsb[3] != null && hsb[3] >= 0 && hsb[3] <= 255);
    }

    final alpha = hsb.length == 4 ? hsb[3].round() : 255;

    return HsbColor(hsb[0], hsb[1], hsb[2], alpha);
  }

  /// Constructs a [HslColor] from [color].
  factory HsbColor.fromColor(Color color) {
    assert(color != null);

    return RgbColor.fromColor(color).toHsbColor();
  }

  /// Constructs a [HsbColor] from a [hex] color.
  ///
  /// [hex] is case-insensitive and must be `3` or `6` characters
  /// in length, excluding an optional leading `#`.
  factory HsbColor.fromHex(String hex) {
    assert(hex != null);

    final hsb = cm.HsbColor.fromHex(hex);

    return HsbColor(hsb.hue, hsb.saturation, hsb.brightness);
  }

  /// Constructs a [HsbColor] from a list of [hsb] values on a `0` to `1` scale.
  ///
  /// [hsb] must not be null and must have exactly `3` or `4` values.
  ///
  /// Each of the values must be `>= 0` and `<= 1`.
  factory HsbColor.extrapolate(List<double> hsb) {
    assert(hsb != null && (hsb.length == 3 || hsb.length == 4));
    assert(hsb[0] != null && hsb[0] >= 0 && hsb[0] <= 1);
    assert(hsb[1] != null && hsb[1] >= 0 && hsb[1] <= 1);
    assert(hsb[2] != null && hsb[2] >= 0 && hsb[2] <= 1);
    if (hsb.length == 4) {
      assert(hsb[3] != null && hsb[3] >= 0 && hsb[3] <= 1);
    }

    final alpha = hsb.length == 4 ? (hsb[3] * 255).round() : 255;

    return HsbColor(hsb[0] * 360, hsb[1] * 100, hsb[2] * 100, alpha);
  }

  /// Generates a [HsbColor] at random.
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
  /// [minBrightness] and [maxBrightness] constrain the generated [brightness] value.
  ///
  /// Min and max values, besides hues, must be `min <= max && max >= min`,
  /// must be in the range of `>= 0 && <= 100`, and must not be `null`.
  factory HsbColor.random({
    num minHue = 0,
    num maxHue = 360,
    num minSaturation = 0,
    num maxSaturation = 100,
    num minBrightness = 0,
    num maxBrightness = 100,
  }) {
    assert(minHue != null && minHue >= 0 && minHue <= 360);
    assert(maxHue != null && maxHue >= 0 && maxHue <= 360);
    assert(minSaturation != null &&
        minSaturation >= 0 &&
        minSaturation <= maxSaturation);
    assert(maxSaturation != null &&
        maxSaturation >= minSaturation &&
        maxSaturation <= 100);
    assert(minBrightness != null &&
        minBrightness >= 0 &&
        minBrightness <= maxBrightness);
    assert(maxBrightness != null &&
        maxBrightness >= minBrightness &&
        maxBrightness <= 100);

    return ToColor.cast(cm.HsbColor.random(
      minHue: minHue,
      maxHue: maxHue,
      minSaturation: minSaturation,
      maxSaturation: maxSaturation,
      minBrightness: minBrightness,
      maxBrightness: maxBrightness,
    ));
  }
}
