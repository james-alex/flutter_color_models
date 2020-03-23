import 'package:flutter/material.dart' show Color;
import 'package:color_models/color_models.dart' as cm;
import '../color_model.dart';
import '../helpers/to_color.dart';

/// A color in the HSI color space.
///
/// The HSI color space contains channels for [hue],
/// [saturation], and [intensity].
class HsiColor extends cm.HsiColor with ToColor {
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
  HsiColor get inverted => ToColor.cast(ToColor.cast(this).inverted);

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

    return ToColor.cast(ToColor.cast(this).warmer(amount, relative: relative));
  }

  @override
  HsiColor cooler(num amount, {bool relative = true}) {
    assert(amount != null && amount > 0);
    assert(relative != null);

    return ToColor.cast(ToColor.cast(this).cooler(amount, relative: relative));
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

    color = ToColor.cast(color);

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
}
