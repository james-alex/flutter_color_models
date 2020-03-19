import 'package:flutter/material.dart' show Color;
import 'package:color_models/color_models.dart' as cm;
import '../color_model.dart';
import './helpers/to_color.dart';

/// A color in the HSL color space.
///
/// The HSL color space contains channels for [hue],
/// [saturation], and [lightness].
class HslColor extends cm.HslColor with ToColor {
  /// A color in the HSL color space.
  ///
  /// [hue] must be `>= 0` and `<= 360`.
  ///
  /// [saturation] and [lightness] must both be `>= 0` and `<= 100`.
  const HslColor(
    num hue,
    num saturation,
    num lightness, [
    num alpha = 1.0,
  ])  : assert(hue != null && hue >= 0 && hue <= 360),
        assert(saturation != null && saturation >= 0 && saturation <= 100),
        assert(lightness != null && lightness >= 0 && lightness <= 100),
        assert(alpha != null && alpha >= 0 && alpha <= 1),
        super(hue, saturation, lightness, alpha);

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
  HslColor withAlpha(num alpha) {
    assert(alpha != null && alpha >= 0 && alpha <= 1);

    return HslColor(hue, saturation, lightness, alpha);
  }

  /// Parses a list for HSL values and returns a [HslColor].
  ///
  /// The hue must be `>= 0` and `<= 360`.
  ///
  /// The saturation and lightness must both be `>= 0` and `<= 100`.
  static HslColor fromList(List<num> hsl) {
    assert(hsl != null && (hsl.length == 3 || hsl.length == 4));
    assert(hsl[0] != null && hsl[0] >= 0 && hsl[0] <= 360);
    assert(hsl[1] != null && hsl[1] >= 0 && hsl[1] <= 100);
    assert(hsl[2] != null && hsl[2] >= 0 && hsl[2] <= 100);
    if (hsl.length == 4) {
      assert(hsl[3] != null && hsl[3] >= 0 && hsl[3] <= 1);
    }

    final alpha = hsl.length == 4 ? hsl[3] : 1.0;

    return HslColor(hsl[0], hsl[1], hsl[2], alpha);
  }

  /// Returns [color] as a [HslColor].
  static HslColor fromColor(Color color) {
    assert(color != null);

    return RgbColor.fromColor(color).toHslColor();
  }

  /// Returns a [color] in another color space as a HSL color.
  static HslColor from(ColorModel color) {
    assert(color != null);

    color = ToColor.cast(color);

    final hsl = cm.ColorConverter.toHslColor(color);

    return HslColor(hsl.hue, hsl.saturation, hsl.lightness);
  }

  /// Returns a [hex] color as a HSL color.
  ///
  /// [hex] is case-insensitive and must be `3` or `6` characters
  /// in length, excluding an optional leading `#`.
  static HslColor fromHex(String hex) {
    assert(hex != null);

    final hsl = cm.HslColor.fromHex(hex);

    return HslColor(hsl.hue, hsl.saturation, hsl.lightness);
  }

  /// Returns a [HslColor] from a list of [hsl] values on a 0 to 1 scale.
  ///
  /// [hsl] must not be null and must have exactly `3` or `4` values.
  ///
  /// Each of the values must be `>= 0` and `<= 1`.
  static HslColor extrapolate(List<double> hsl) {
    assert(hsl != null && (hsl.length == 3 || hsl.length == 4));
    assert(hsl[0] != null && hsl[0] >= 0 && hsl[0] <= 1);
    assert(hsl[1] != null && hsl[1] >= 0 && hsl[1] <= 1);
    assert(hsl[2] != null && hsl[2] >= 0 && hsl[2] <= 1);
    if (hsl.length == 4) {
      assert(hsl[3] != null && hsl[3] >= 0 && hsl[3] <= 1);
    }

    final alpha = hsl.length == 4 ? hsl[3] : 1.0;

    return HslColor(hsl[0] * 360, hsl[1] * 100, hsl[2] * 100, alpha);
  }
}
