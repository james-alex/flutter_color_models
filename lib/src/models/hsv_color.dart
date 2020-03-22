import 'package:flutter/material.dart' show Color;
import 'package:color_models/color_models.dart' as cm;
import '../color_model.dart';
import './helpers/to_color.dart';

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
}
