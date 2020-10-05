import 'package:flutter/painting.dart' show Color;
import 'package:color_models/color_models.dart' as cm;
import '../color_model.dart';
import 'helpers/as_color.dart';
import 'helpers/rgb_getters.dart';
import 'helpers/to_color.dart';

/// A color in the HSP color space.
///
/// The HSP color space contains channels for [hue],
/// [saturation], and [perceivedBrightness].
///
/// The HSP color space was created in 2006 by Darel Rex Finley.
/// Read about it here: http://alienryderflex.com/hsp.html
class HspColor extends cm.HspColor
    with AsColor, RgbGetters, ToColor
    implements ColorModel {
  /// A color in the HSP color space.
  ///
  /// [hue] must be `>= 0` and `<= 360`.
  ///
  /// [saturation] and [perceivedBrightness] must both be `>= 0` and `<= 100`.
  const HspColor(
    num hue,
    num saturation,
    num perceivedBrightness, [
    int alpha = 255,
  ])  : assert(hue != null && hue >= 0 && hue <= 360),
        assert(saturation != null && saturation >= 0 && saturation <= 100),
        assert(perceivedBrightness != null &&
            perceivedBrightness >= 0 &&
            perceivedBrightness <= 100),
        assert(alpha != null && alpha >= 0 && alpha <= 255),
        super(hue, saturation, perceivedBrightness, alpha);

  @override
  int get value => toColor().value;

  @override
  List<HspColor> lerpTo(
    cm.ColorModel color,
    int steps, {
    bool excludeOriginalColors = false,
  }) {
    assert(color != null);
    assert(steps != null && steps > 0);
    assert(excludeOriginalColors != null);

    final colors = ToColor.cast(this).lerpTo(ToColor.cast(color), steps,
        excludeOriginalColors: excludeOriginalColors);

    return List<HspColor>.from(colors.map(ToColor.cast));
  }

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
  HspColor warmer(num amount, {bool relative = true}) {
    assert(amount != null && amount > 0);
    assert(relative != null);

    return ToColor.cast(ToColor.cast(this).warmer(amount, relative: relative));
  }

  @override
  HspColor cooler(num amount, {bool relative = true}) {
    assert(amount != null && amount > 0);
    assert(relative != null);

    return ToColor.cast(ToColor.cast(this).cooler(amount, relative: relative));
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
  HspColor withRed(num red) {
    assert(red != null && red >= 0 && red <= 255);

    return toRgbColor().withRed(red).toHspColor();
  }

  @override
  HspColor withGreen(num green) {
    assert(green != null && green >= 0 && green <= 255);

    return toRgbColor().withGreen(green).toHspColor();
  }

  @override
  HspColor withBlue(num blue) {
    assert(blue != null && blue >= 0 && blue <= 255);

    return toRgbColor().withBlue(blue).toHspColor();
  }

  @override
  HspColor withAlpha(int alpha) {
    assert(alpha != null && alpha >= 0 && alpha <= 255);

    return HspColor(hue, saturation, perceivedBrightness, alpha);
  }

  @override
  HspColor withOpacity(double opacity) {
    assert(opacity != null && opacity >= 0.0 && opacity <= 1.0);

    return withAlpha((opacity * 255).round());
  }

  @override
  HspColor toHspColor() => this;

  /// Constructs a [HspColor] from [color].
  factory HspColor.from(cm.ColorModel color) {
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
      assert(hsp[3] != null && hsp[3] >= 0 && hsp[3] <= 255);
    }

    final alpha = hsp.length == 4 ? hsp[3].round() : 255;

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

    final alpha = hsp.length == 4 ? (hsp[3] * 255).round() : 255;

    return HspColor(hsp[0] * 360, hsp[1] * 100, hsp[2] * 100, alpha);
  }

  /// Generates a [HspColor] at random.
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
  /// [minPerceivedBrightness] and [maxPerceivedBrightness] constrain the
  /// generated [perceivedBrightness] value.
  ///
  /// Min and max values, besides hues, must be `min <= max && max >= min`,
  /// must be in the range of `>= 0 && <= 100`, and must not be `null`.
  factory HspColor.random({
    num minHue = 0,
    num maxHue = 360,
    num minSaturation = 0,
    num maxSaturation = 100,
    num minPerceivedBrightness = 0,
    num maxPerceivedBrightness = 100,
  }) {
    assert(minHue != null && minHue >= 0 && minHue <= 360);
    assert(maxHue != null && maxHue >= 0 && maxHue <= 360);
    assert(minSaturation != null &&
        minSaturation >= 0 &&
        minSaturation <= maxSaturation);
    assert(maxSaturation != null &&
        maxSaturation >= minSaturation &&
        maxSaturation <= 100);
    assert(minPerceivedBrightness != null &&
        minPerceivedBrightness >= 0 &&
        minPerceivedBrightness <= maxPerceivedBrightness);
    assert(maxPerceivedBrightness != null &&
        maxPerceivedBrightness >= minPerceivedBrightness &&
        maxPerceivedBrightness <= 100);

    return ToColor.cast(cm.HspColor.random(
      minHue: minHue,
      maxHue: maxHue,
      minSaturation: minSaturation,
      maxSaturation: maxSaturation,
      minPerceivedBrightness: minPerceivedBrightness,
      maxPerceivedBrightness: maxPerceivedBrightness,
    ));
  }
}
