import 'package:flutter/material.dart' show Color;
import 'package:color_models/color_models.dart' as cm;
import '../color_model.dart';
import '../helpers/cast_color.dart';

/// A color in the HSI color space.
///
/// The HSI color space contains channels for [hue],
/// [saturation], and [intensity].
class HsiColor extends cm.HsiColor with CastColor {
  /// A color in the HSV (HSB) color space.
  ///
  /// [hue] must be `>= 0` and `<= 360`.
  ///
  /// [saturation] and [intensity] must both be `>= 0` and `<= 100`.
  const HsiColor(
    num hue,
    num saturation,
    num intensity, [
    num alpha = 1.0,
  ])  : assert(hue != null && hue >= 0 && hue <= 360),
        assert(saturation != null && saturation >= 0 && saturation <= 100),
        assert(intensity != null && intensity >= 0 && intensity <= 100),
        assert(alpha != null && alpha >= 0 && alpha <= 1),
        super(hue, saturation, intensity, alpha);

  @override
  HsiColor get inverted => CastColor.cast(CastColor.cast(this).inverted);

  @override
  HsiColor get opposite => rotateHue(180);

  @override
  HsiColor rotateHue(num amount) {
    assert(amount != null);

    final hslColor = toHslColor();

    return withHue((hslColor.hue + amount) % 360);
  }

  @override
  HsiColor warmer(num amount, {bool relative = true}) {
    assert(amount != null && amount > 0);
    assert(relative != null);

    return CastColor.cast(CastColor.cast(this).warmer(amount, relative: relative));
  }

  @override
  HsiColor cooler(num amount, {bool relative = true}) {
    assert(amount != null && amount > 0);
    assert(relative != null);

    return CastColor.cast(CastColor.cast(this).cooler(amount, relative: relative));
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
  HsiColor withAlpha(num alpha) {
    assert(alpha != null && alpha >= 0 && alpha <= 1);

    return HsiColor(hue, saturation, intensity, alpha);
  }

  /// Constructs a [HsiColor] from [color].
  factory HsiColor.from(ColorModel color) {
    assert(color != null);

    color = CastColor.cast(color);

    final hsi = cm.ColorConverter.toHsiColor(color);

    return HsiColor(hsi.hue, hsi.saturation, hsi.intensity);
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
      assert(hsi[3] != null && hsi[3] >= 0 && hsi[3] <= 1);
    }

    final alpha = hsi.length == 4 ? hsi[3] : 1.0;

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

    final alpha = hsi.length == 4 ? hsi[3] : 1.0;

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

    return CastColor.cast(cm.HsiColor.random(
      minHue: minHue,
      maxHue: maxHue,
      minSaturation: minSaturation,
      maxSaturation: maxSaturation,
      minIntensity: minIntensity,
      maxIntensity: maxIntensity,
    ));
  }
}
