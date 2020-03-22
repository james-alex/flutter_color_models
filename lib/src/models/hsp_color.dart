import 'package:flutter/material.dart' show Color;
import 'package:color_models/color_models.dart' as cm;
import '../color_model.dart';
import '../helpers/to_color.dart';

/// A color in the HSP color space.
///
/// The HSP color space contains channels for [hue],
/// [saturation], and [perceivedBrightness].
///
/// The HSP color space was created in 2006 by Darel Rex Finley.
/// Read about it here: http://alienryderflex.com/hsp.html
class HspColor extends cm.HspColor with ToColor {
  /// A color in the HSP color space.
  ///
  /// [hue] must be `>= 0` and `<= 360`.
  ///
  /// [saturation] and [perceivedBrightness] must both be `>= 0` and `<= 100`.
  const HspColor(
    num hue,
    num saturation,
    num perceivedBrightness, [
    num alpha = 1.0,
  ])  : assert(hue != null && hue >= 0 && hue <= 360),
        assert(saturation != null && saturation >= 0 && saturation <= 100),
        assert(perceivedBrightness != null &&
            perceivedBrightness >= 0 &&
            perceivedBrightness <= 100),
        assert(alpha != null && alpha >= 0 && alpha <= 1),
        super(hue, saturation, perceivedBrightness, alpha);

  @override
  HspColor get inverted => ToColor.cast(ToColor.cast(this).inverted);

  @override
  HspColor get opposite => rotateHue(180);

  @override
  HspColor rotateHue(num amount) {
    assert(amount != null);

    final hslColor = toHslColor();

    return withHue((hslColor.hue + amount) % 360);
  }

  @override
  HspColor warmer(num amount) {
    assert(amount != null && amount > 0);

    return ToColor.cast(ToColor.cast(this).warmer(amount));
  }

  @override
  HspColor cooler(num amount) {
    assert(amount != null && amount > 0);

    return ToColor.cast(ToColor.cast(this).cooler(amount));
  }

  @override
  HspColor withHue(num hue) {
    assert(hue != null && hue >= 0 && hue <= 360);

    return HspColor(hue, saturation, perceivedBrightness, alpha);
  }

  @override
  HspColor withSaturation(num saturation) {
    assert(saturation != null && saturation >= 0 && saturation <= 100);

    return HspColor(hue, saturation, perceivedBrightness, alpha);
  }

  @override
  HspColor withPerceivedBrightness(num perceivedBrightness) {
    assert(perceivedBrightness != null &&
        perceivedBrightness >= 0 &&
        perceivedBrightness <= 100);

    return HspColor(hue, saturation, perceivedBrightness, alpha);
  }

  @override
  HspColor withAlpha(num alpha) {
    assert(alpha != null && alpha >= 0 && alpha <= 1);

    return HspColor(hue, saturation, perceivedBrightness, alpha);
  }

  /// Constructs a [HspColor] from [color].
  factory HspColor.from(ColorModel color) {
    assert(color != null);

    color = ToColor.cast(color);

    final hsp = cm.ColorConverter.toHspColor(color);

    return HspColor(hsp.hue, hsp.saturation, hsp.perceivedBrightness);
  }

  /// Constructs a [HspColor] from a list of [hsp] values.
  ///
  /// [hsp] must not be null and must have exactly `3` or `4` values.
  ///
  /// The hue must be `>= 0` and `<= 360`.
  ///
  /// The saturation and perceived brightness must both be `>= 0` and `<= 100`.
  factory HspColor.fromList(List<num> hsp) {
    assert(hsp != null && (hsp.length == 3 || hsp.length == 4));
    assert(hsp[0] != null && hsp[0] >= 0 && hsp[0] <= 360);
    assert(hsp[1] != null && hsp[1] >= 0 && hsp[1] <= 100);
    assert(hsp[2] != null && hsp[2] >= 0 && hsp[2] <= 100);
    if (hsp.length == 4) {
      assert(hsp[3] != null && hsp[3] >= 0 && hsp[3] <= 1);
    }

    final alpha = hsp.length == 4 ? hsp[3] : 1.0;

    return HspColor(hsp[0], hsp[1], hsp[2], alpha);
  }

  /// Constructs a [HspColor] from [color].
  factory HspColor.fromColor(Color color) {
    assert(color != null);

    return RgbColor.fromColor(color).toHspColor();
  }

  /// Constructs a [HspColor] from a [hex] color.
  ///
  /// [hex] is case-insensitive and must be `3` or `6` characters
  /// in length, excluding an optional leading `#`.
  factory HspColor.fromHex(String hex) {
    assert(hex != null);

    final hsp = cm.HspColor.fromHex(hex);

    return HspColor(hsp.hue, hsp.saturation, hsp.perceivedBrightness);
  }

  /// Constructs a [HspColor] from a list of [hsp] values on a `0` to `1` scale.
  ///
  /// [hsp] must not be null and must have exactly `3` or `4` values.
  ///
  /// Each of the values must be `>= 0` and `<= 1`.
  factory HspColor.extrapolate(List<double> hsp) {
    assert(hsp != null && (hsp.length == 3 || hsp.length == 4));
    assert(hsp[0] != null && hsp[0] >= 0 && hsp[0] <= 1);
    assert(hsp[1] != null && hsp[1] >= 0 && hsp[1] <= 1);
    assert(hsp[2] != null && hsp[2] >= 0 && hsp[2] <= 1);
    if (hsp.length == 4) {
      assert(hsp[3] != null && hsp[3] >= 0 && hsp[3] <= 1);
    }

    final alpha = hsp.length == 4 ? hsp[3] : 1.0;

    return HspColor(hsp[0] * 360, hsp[1] * 100, hsp[2] * 100, alpha);
  }
}
