import 'package:flutter/painting.dart' show Color;
import 'package:color_models/color_models.dart' as cm;
import '../color_model.dart';
import 'helpers/as_color.dart';
import 'helpers/rgb_getters.dart';
import 'helpers/to_color.dart';

/// A color in the HSL color space.
///
/// The HSL color space contains channels for [hue],
/// [saturation], and [lightness].
class HslColor extends cm.HslColor with AsColor, RgbGetters, ToColor implements Color {
  /// A color in the HSL color space.
  ///
  /// [hue] must be `>= 0` and `<= 360`.
  ///
  /// [saturation] and [lightness] must both be `>= 0` and `<= 100`.
  const HslColor(
    num hue,
    num saturation,
    num lightness, [
    int alpha = 255,
  ])  : assert(hue != null && hue >= 0 && hue <= 360),
        assert(saturation != null && saturation >= 0 && saturation <= 100),
        assert(lightness != null && lightness >= 0 && lightness <= 100),
        assert(alpha != null && alpha >= 0 && alpha <= 255),
        super(hue, saturation, lightness, alpha);

  @override
  int get value => toColor().value;

  @override
  List<HslColor> lerpTo(
    ColorModel color,
    int steps, {
    bool excludeOriginalColors = false,
  }) {
    assert(color != null);
    assert(steps != null && steps > 0);
    assert(excludeOriginalColors != null);

    final colors = ToColor.cast(this).lerpTo(ToColor.cast(color), steps,
        excludeOriginalColors: excludeOriginalColors);

    return List<HslColor>.from(colors.map(ToColor.cast));
  }

  @override
  HslColor get inverted => ToColor.cast(ToColor.cast(this).inverted);

  @override
  HslColor get opposite => rotateHue(180);

  @override
  HslColor rotateHue(num amount) {
    assert(amount != null);

    final hslColor = toHslColor();

    return withHue((hslColor.hue + amount) % 360);
  }

  @override
  HslColor warmer(num amount, {bool relative = true}) {
    assert(amount != null && amount > 0);
    assert(relative != null);

    return ToColor.cast(ToColor.cast(this).warmer(amount, relative: relative));
  }

  @override
  HslColor cooler(num amount, {bool relative = true}) {
    assert(amount != null && amount > 0);
    assert(relative != null);

    return ToColor.cast(ToColor.cast(this).cooler(amount, relative: relative));
  }

  @override
  HslColor withHue(num hue) {
    assert(hue != null && hue >= 0 && hue <= 360);

    return HslColor(hue, saturation, lightness, alpha);
  }

  @override
  HslColor withSaturation(num saturation) {
    assert(saturation != null && saturation >= 0 && saturation <= 100);

    return HslColor(hue, saturation, lightness, alpha);
  }

  @override
  HslColor withLightness(num lightness) {
    assert(lightness != null && lightness >= 0 && lightness <= 100);

    return HslColor(hue, saturation, lightness, alpha);
  }

  @override
  HslColor withRed(num red) {
    assert(red != null && red >= 0 && red <= 255);

    return toRgbColor().withRed(red).toHslColor();
  }

  @override
  HslColor withGreen(num green) {
    assert(green != null && green >= 0 && green <= 255);

    return toRgbColor().withGreen(green).toHslColor();
  }

  @override
  HslColor withBlue(num blue) {
    assert(blue != null && blue >= 0 && blue <= 255);

    return toRgbColor().withBlue(blue).toHslColor();
  }

  @override
  HslColor withAlpha(int alpha) {
    assert(alpha != null && alpha >= 0 && alpha <= 255);

    return HslColor(hue, saturation, lightness, alpha);
  }

  @override
  HslColor withOpacity(double opacity) {
    assert(opacity != null && opacity >= 0.0 && opacity <= 1.0);

    return withAlpha((opacity * 255).round());
  }

  @override
  HslColor toHslColor() => this;

  /// Constructs a [HslColor] from [color].
  factory HslColor.from(ColorModel color) {
    assert(color != null);

    color = ToColor.cast(color);

    final hsl = cm.ColorConverter.toHslColor(color);

    return HslColor(hsl.hue, hsl.saturation, hsl.lightness);
  }

  /// Constructs a [HslColor] from a list of [hsl] values.
  ///
  /// The hue must be `>= 0` and `<= 360`.
  ///
  /// The saturation and lightness must both be `>= 0` and `<= 100`.
  factory HslColor.fromList(List<num> hsl) {
    assert(hsl != null && (hsl.length == 3 || hsl.length == 4));
    assert(hsl[0] != null && hsl[0] >= 0 && hsl[0] <= 360);
    assert(hsl[1] != null && hsl[1] >= 0 && hsl[1] <= 100);
    assert(hsl[2] != null && hsl[2] >= 0 && hsl[2] <= 100);
    if (hsl.length == 4) {
      assert(hsl[3] != null && hsl[3] >= 0 && hsl[3] <= 255);
    }

    final alpha = hsl.length == 4 ? hsl[3].round() : 255;

    return HslColor(hsl[0], hsl[1], hsl[2], alpha);
  }

  /// Constructs a [HslColor] from [color].
  factory HslColor.fromColor(Color color) {
    assert(color != null);

    return RgbColor.fromColor(color).toHslColor();
  }

  /// Constructs a [HslColor] from a [hex] color.
  ///
  /// [hex] is case-insensitive and must be `3` or `6` characters
  /// in length, excluding an optional leading `#`.
  factory HslColor.fromHex(String hex) {
    assert(hex != null);

    final hsl = cm.HslColor.fromHex(hex);

    return HslColor(hsl.hue, hsl.saturation, hsl.lightness);
  }

  /// Constructs a [HslColor] from a list of [hsl] values on a `0` to `1` scale.
  ///
  /// [hsl] must not be null and must have exactly `3` or `4` values.
  ///
  /// Each of the values must be `>= 0` and `<= 1`.
  factory HslColor.extrapolate(List<double> hsl) {
    assert(hsl != null && (hsl.length == 3 || hsl.length == 4));
    assert(hsl[0] != null && hsl[0] >= 0 && hsl[0] <= 1);
    assert(hsl[1] != null && hsl[1] >= 0 && hsl[1] <= 1);
    assert(hsl[2] != null && hsl[2] >= 0 && hsl[2] <= 1);
    if (hsl.length == 4) {
      assert(hsl[3] != null && hsl[3] >= 0 && hsl[3] <= 1);
    }

    final alpha = hsl.length == 4 ? (hsl[3] * 255).round() : 255;

    return HslColor(hsl[0] * 360, hsl[1] * 100, hsl[2] * 100, alpha);
  }

  /// Generates a [HslColor] at random.
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
  /// [minLightness] and [maxLightness] constrain the generated [lightness]
  /// value.
  ///
  /// Min and max values, besides hues, must be `min <= max && max >= min`,
  /// must be in the range of `>= 0 && <= 100`, and must not be `null`.
  factory HslColor.random({
    num minHue = 0,
    num maxHue = 360,
    num minSaturation = 0,
    num maxSaturation = 100,
    num minLightness = 0,
    num maxLightness = 100,
  }) {
    assert(minHue != null && minHue >= 0 && minHue <= 360);
    assert(maxHue != null && maxHue >= 0 && maxHue <= 360);
    assert(minSaturation != null &&
        minSaturation >= 0 &&
        minSaturation <= maxSaturation);
    assert(maxSaturation != null &&
        maxSaturation >= minSaturation &&
        maxSaturation <= 100);
    assert(minLightness != null &&
        minLightness >= 0 &&
        minLightness <= maxLightness);
    assert(maxLightness != null &&
        maxLightness >= minLightness &&
        maxLightness <= 100);

    return ToColor.cast(cm.HslColor.random(
      minHue: minHue,
      maxHue: maxHue,
      minSaturation: minSaturation,
      maxSaturation: maxSaturation,
      minLightness: minLightness,
      maxLightness: maxLightness,
    ));
  }
}
