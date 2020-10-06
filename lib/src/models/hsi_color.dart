import 'package:flutter/painting.dart' show Color;
import 'package:color_models/color_models.dart' as cm;
import '../color_model.dart';
import 'helpers/as_color.dart';
import 'helpers/rgb_getters.dart';
import 'helpers/to_color.dart';

/// A color in the HSI color space.
///
/// The HSI color space contains channels for [hue],
/// [saturation], and [intensity].
class HsiColor extends cm.HsiColor
    with AsColor, RgbGetters, ToColor
    implements ColorModel {
  /// A color in the HSI color space.
  ///
  /// [hue] must be `>= 0` and `<= 360`.
  ///
  /// [saturation] and [intensity] must both be `>= 0` and `<= 100`.
  const HsiColor(
    num hue,
    num saturation,
    num intensity, [
    int alpha = 255,
  ])  : assert(hue != null && hue >= 0 && hue <= 360),
        assert(saturation != null && saturation >= 0 && saturation <= 100),
        assert(intensity != null && intensity >= 0 && intensity <= 100),
        assert(alpha != null && alpha >= 0 && alpha <= 255),
        super(hue, saturation, intensity, alpha);

  @override
  int get value => toColor().value;

  @override
  List<HsiColor> lerpTo(
    cm.ColorModel color,
    int steps, {
    bool excludeOriginalColors = false,
  }) {
    assert(color != null);
    assert(steps != null && steps > 0);
    assert(excludeOriginalColors != null);

    final colors = ToColor.cast(this).lerpTo(ToColor.cast(color), steps,
        excludeOriginalColors: excludeOriginalColors);

    return List<HsiColor>.from(colors.map(ToColor.cast));
  }

  @override
  HsiColor get inverted => ToColor.cast(super.inverted);

  @override
  HsiColor get opposite => rotateHue(180);

  @override
  HsiColor rotateHue(num amount) {
    assert(amount != null);

    return ToColor.cast(super.rotateHue(amount));
  }

  @override
  HsiColor warmer(num amount, {bool relative = true}) {
    assert(amount != null && amount > 0);
    assert(relative != null);

    return ToColor.cast(super.warmer(amount, relative: relative));
  }

  @override
  HsiColor cooler(num amount, {bool relative = true}) {
    assert(amount != null && amount > 0);
    assert(relative != null);

    return ToColor.cast(super.cooler(amount, relative: relative));
  }

  @override
  HsiColor withHue(num hue) {
    assert(hue != null && hue >= 0 && hue <= 360);

    return HsiColor(hue, saturation, intensity, alpha);
  }

  @override
  HsiColor withSaturation(num saturation) {
    assert(saturation != null && saturation >= 0 && saturation <= 100);

    return HsiColor(hue, saturation, intensity, alpha);
  }

  @override
  HsiColor withIntensity(num intensity) {
    assert(intensity != null && intensity >= 0 && intensity <= 100);

    return HsiColor(hue, saturation, intensity, alpha);
  }

  @override
  HsiColor withRed(num red) {
    assert(red != null && red >= 0 && red <= 255);

    return toRgbColor().withRed(red).toHsiColor();
  }

  @override
  HsiColor withGreen(num green) {
    assert(green != null && green >= 0 && green <= 255);

    return toRgbColor().withGreen(green).toHsiColor();
  }

  @override
  HsiColor withBlue(num blue) {
    assert(blue != null && blue >= 0 && blue <= 255);

    return toRgbColor().withBlue(blue).toHsiColor();
  }

  @override
  HsiColor withAlpha(int alpha) {
    assert(alpha != null && alpha >= 0 && alpha <= 255);

    return HsiColor(hue, saturation, intensity, alpha);
  }

  @override
  HsiColor withOpacity(double opacity) {
    assert(opacity != null && opacity >= 0.0 && opacity <= 1.0);

    return withAlpha((opacity * 255).round());
  }

  @override
  HsiColor toHsiColor() => this;

  /// Constructs a [HsiColor] from [color].
  factory HsiColor.from(cm.ColorModel color) {
    assert(color != null);

    color = ToColor.cast(color);

    final hsi = cm.ColorConverter.toHsiColor(color);

    return HsiColor(hsi.hue, hsi.saturation, hsi.intensity, hsi.alpha);
  }

  /// Constructs a [HsiColor] from a list of [hsi] values.
  ///
  /// [hsi] must not be null and must have exactly `3` or `4` values.
  ///
  /// The hue must be `>= 0` and `<= 360`.
  ///
  /// The saturation and intensity must both be `>= 0` and `<= 100`.
  factory HsiColor.fromList(List<num> hsi) {
    assert(hsi != null && (hsi.length == 3 || hsi.length == 4));
    assert(hsi[0] != null && hsi[0] >= 0 && hsi[0] <= 360);
    assert(hsi[1] != null && hsi[1] >= 0 && hsi[1] <= 100);
    assert(hsi[2] != null && hsi[2] >= 0 && hsi[2] <= 100);
    if (hsi.length == 4) {
      assert(hsi[3] != null && hsi[3] >= 0 && hsi[3] <= 255);
    }

    final alpha = hsi.length == 4 ? hsi[3].round() : 255;

    return HsiColor(hsi[0], hsi[1], hsi[2], alpha);
  }

  /// Constructs a [HsiColor] from [color].
  factory HsiColor.fromColor(Color color) {
    assert(color != null);

    return RgbColor.fromColor(color).toHsiColor();
  }

  /// Constructs a [HsiColor] from a [hex] color.
  ///
  /// [hex] is case-insensitive and must be `3` or `6` characters
  /// in length, excluding an optional leading `#`.
  factory HsiColor.fromHex(String hex) {
    assert(hex != null);

    final hsi = cm.HsiColor.fromHex(hex);

    return HsiColor(hsi.hue, hsi.saturation, hsi.intensity);
  }

  /// Constructs a [HsiColor] from a list of [hsi] values on a `0` to `1` scale.
  ///
  /// [hsi] must not be null and must have exactly `3` or `4` values.
  ///
  /// Each of the values must be `>= 0` and `<= 1`.
  factory HsiColor.extrapolate(List<double> hsi) {
    assert(hsi != null && (hsi.length == 3 || hsi.length == 4));
    assert(hsi[0] != null && hsi[0] >= 0 && hsi[0] <= 1);
    assert(hsi[1] != null && hsi[1] >= 0 && hsi[1] <= 1);
    assert(hsi[2] != null && hsi[2] >= 0 && hsi[2] <= 1);
    if (hsi.length == 4) {
      assert(hsi[3] != null && hsi[3] >= 0 && hsi[3] <= 1);
    }

    final alpha = hsi.length == 4 ? (hsi[3] * 255).round() : 255;

    return HsiColor(hsi[0] * 360, hsi[1] * 100, hsi[2] * 100, alpha);
  }

  /// Generates a [HsiColor] at random.
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
  /// [minIntensity] and [maxIntensity] constrain the generated [intensity]
  /// value.
  ///
  /// Min and max values, besides hues, must be `min <= max && max >= min`,
  /// must be in the range of `>= 0 && <= 100`, and must not be `null`.
  factory HsiColor.random({
    num minHue = 0,
    num maxHue = 360,
    num minSaturation = 0,
    num maxSaturation = 100,
    num minIntensity = 0,
    num maxIntensity = 100,
  }) {
    assert(minHue != null && minHue >= 0 && minHue <= 360);
    assert(maxHue != null && maxHue >= 0 && maxHue <= 360);
    assert(minSaturation != null &&
        minSaturation >= 0 &&
        minSaturation <= maxSaturation);
    assert(maxSaturation != null &&
        maxSaturation >= minSaturation &&
        maxSaturation <= 100);
    assert(minIntensity != null &&
        minIntensity >= 0 &&
        minIntensity <= maxIntensity);
    assert(maxIntensity != null &&
        maxIntensity >= minIntensity &&
        maxIntensity <= 100);

    return ToColor.cast(cm.HsiColor.random(
      minHue: minHue,
      maxHue: maxHue,
      minSaturation: minSaturation,
      maxSaturation: maxSaturation,
      minIntensity: minIntensity,
      maxIntensity: maxIntensity,
    ));
  }
}
