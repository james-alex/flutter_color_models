import 'package:flutter/material.dart' show Color;
import 'package:color_models/color_models.dart' as cm;
import '../color_model.dart';
import '../helpers/to_color.dart';

/// A color in the CMYK color space.
///
/// The CMYK color space contains channels for [cyan],
/// [magenta], [yellow], and [black].
class CmykColor extends cm.CmykColor with ToColor {
  /// A color in the CMYK color space.
  ///
  /// [cyan], [magenta], [yellow], and [black]
  /// must all be `>= 0` and `<= 100`.
  const CmykColor(
    num cyan,
    num magenta,
    num yellow,
    num black, [
    num alpha = 1.0,
  ])  : assert(cyan != null && cyan >= 0 && cyan <= 100),
        assert(magenta != null && magenta >= 0 && magenta <= 100),
        assert(yellow != null && yellow >= 0 && yellow <= 100),
        assert(black != null && black >= 0 && black <= 100),
        assert(alpha != null && alpha >= 0 && alpha <= 1),
        super(cyan, magenta, yellow, black, alpha);

  @override
  List<CmykColor> interpolateTo(
    ColorModel color,
    int steps, {
    bool excludeOriginalColors = false,
  }) {
    assert(color != null);
    assert(steps != null && steps > 0);
    assert(excludeOriginalColors != null);

    final colors = ToColor.cast(this).interpolateTo(ToColor.cast(color), steps,
        excludeOriginalColors: excludeOriginalColors);

    return List<CmykColor>.from(colors.map(ToColor.cast));
  }

  @override
  CmykColor get inverted => ToColor.cast(ToColor.cast(this).inverted);

  @override
  CmykColor get opposite => rotateHue(180);

  @override
  CmykColor rotateHue(num amount) {
    assert(amount != null);

    final hslColor = toHslColor();

    return hslColor.withHue((hslColor.hue + amount) % 360).toCmykColor();
  }

  @override
  CmykColor warmer(num amount, {bool relative = true}) {
    assert(amount != null && amount > 0);
    assert(relative != null);

    return ToColor.cast(ToColor.cast(this).warmer(amount, relative: relative));
  }

  @override
  CmykColor cooler(num amount, {bool relative = true}) {
    assert(amount != null && amount > 0);
    assert(relative != null);

    return ToColor.cast(ToColor.cast(this).cooler(amount, relative: relative));
  }

  @override
  CmykColor withCyan(num cyan) {
    assert(cyan != null && cyan >= 0 && cyan <= 100);

    return CmykColor(cyan, magenta, yellow, black, alpha);
  }

  @override
  CmykColor withMagenta(num magenta) {
    assert(magenta != null && magenta >= 0 && magenta <= 100);

    return CmykColor(cyan, magenta, yellow, black, alpha);
  }

  @override
  CmykColor withYellow(num yellow) {
    assert(yellow != null && yellow >= 0 && yellow <= 100);

    return CmykColor(cyan, magenta, yellow, black, alpha);
  }

  @override
  CmykColor withBlack(num black) {
    assert(black != null && black >= 0 && black <= 100);

    return CmykColor(cyan, magenta, yellow, black, alpha);
  }

  /// Returns this [CmykColor] modified with the provided [alpha] value.
  @override
  CmykColor withAlpha(num alpha) {
    assert(alpha != null && alpha >= 0 && alpha <= 1);

    return CmykColor(cyan, magenta, yellow, black, alpha);
  }

  @override
  CmykColor withHue(num hue) {
    assert(hue != null && hue >= 0 && hue <= 360);

    final hslColor = toHslColor();

    return hslColor.withHue((hslColor.hue + hue) % 360).toCmykColor();
  }

  @override
  CmykColor toCmykColor() => this;

  /// Constructs a [CmykColor] from [color].
  factory CmykColor.from(ColorModel color) {
    assert(color != null);

    color = ToColor.cast(color);

    final cmyk = cm.ColorConverter.toCmykColor(color);

    return CmykColor(cmyk.cyan, cmyk.magenta, cmyk.yellow, cmyk.black);
  }

  /// Constructs a [CmykColor] from a list of [cmyk] values.
  ///
  /// [cmyk] must not be null and must have exactly `4` or `5` values.
  ///
  /// Each color value must be `>= 0 && <= 100`.
  factory CmykColor.fromList(List<num> cmyk) {
    assert(cmyk != null && (cmyk.length == 4 || cmyk.length == 5));
    assert(cmyk[0] != null && cmyk[0] >= 0 && cmyk[0] <= 100);
    assert(cmyk[1] != null && cmyk[1] >= 0 && cmyk[1] <= 100);
    assert(cmyk[2] != null && cmyk[2] >= 0 && cmyk[2] <= 100);
    assert(cmyk[3] != null && cmyk[3] >= 0 && cmyk[3] <= 100);
    if (cmyk.length == 5) {
      assert(cmyk[4] != null && cmyk[4] >= 0 && cmyk[4] <= 1);
    }

    final alpha = cmyk.length == 5 ? cmyk[4] : 1.0;

    return CmykColor(cmyk[0], cmyk[1], cmyk[2], cmyk[3], alpha);
  }

  /// Constructs a [CmykColor] from [color].
  factory CmykColor.fromColor(Color color) {
    assert(color != null);

    return RgbColor.fromColor(color).toCmykColor();
  }

  /// Constructs a [CmykColor] from a [hex] color.
  ///
  /// [hex] is case-insensitive and must be `3` or `6` characters
  /// in length, excluding an optional leading `#`.
  factory CmykColor.fromHex(String hex) {
    assert(hex != null);

    final cmyk = cm.CmykColor.fromHex(hex);

    return CmykColor(cmyk.cyan, cmyk.magenta, cmyk.yellow, cmyk.black);
  }

  /// Constructs a [CmykColor] from a list of [cmyk] values
  /// on a `0` to `1` scale.
  ///
  /// [cmyk] must not be null and must have exactly `4` or `5` values.
  ///
  /// Each of the values must be `>= 0` and `<= 1`.
  factory CmykColor.extrapolate(List<double> cmyk) {
    assert(cmyk != null && (cmyk.length == 4 || cmyk.length == 5));
    assert(cmyk[0] != null && cmyk[0] >= 0 && cmyk[0] <= 1);
    assert(cmyk[1] != null && cmyk[1] >= 0 && cmyk[1] <= 1);
    assert(cmyk[2] != null && cmyk[2] >= 0 && cmyk[2] <= 1);
    assert(cmyk[3] != null && cmyk[3] >= 0 && cmyk[3] <= 1);
    if (cmyk.length == 5) {
      assert(cmyk[4] != null && cmyk[4] >= 0 && cmyk[4] <= 1);
    }

    final alpha = cmyk.length == 5 ? cmyk[4] : 1.0;

    return CmykColor(
        cmyk[0] * 100, cmyk[1] * 100, cmyk[2] * 100, cmyk[3] * 100, alpha);
  }

  /// Generates a [CmykColor] at random.
  ///
  /// [minCyan] and [maxCyan] constrain the generated [cyan] value.
  ///
  /// [minMagenta] and [maxMagenta] constrain the generated [magenta] value.
  ///
  /// [minYellow] and [maxYellow] constrain the generated [yellow] value.
  ///
  /// [minBlack] and [maxBlack] constrain the generated [black] value.
  ///
  /// All min and max values must be `min <= max && max >= min`, must be
  /// in the range of `>= 0 && <= 100`, and must not be `null`.
  factory CmykColor.random({
    num minCyan = 0,
    num maxCyan = 100,
    num minMagenta = 0,
    num maxMagenta = 100,
    num minYellow = 0,
    num maxYellow = 100,
    num minBlack = 0,
    num maxBlack = 100,
  }) {
    assert(minCyan != null && minCyan >= 0 && minCyan <= maxCyan);
    assert(maxCyan != null && maxCyan >= minCyan && maxCyan <= 100);
    assert(minMagenta != null && minMagenta >= 0 && minMagenta <= maxMagenta);
    assert(maxMagenta != null && maxMagenta >= minMagenta && maxMagenta <= 100);
    assert(minYellow != null && minYellow >= 0 && minYellow <= maxYellow);
    assert(maxYellow != null && maxYellow >= minYellow && maxYellow <= 100);
    assert(minBlack != null && minBlack >= 0 && minBlack <= maxBlack);
    assert(maxBlack != null && maxBlack >= minBlack && maxBlack <= 100);

    return ToColor.cast(cm.CmykColor.random(
      minCyan: minCyan,
      maxCyan: maxCyan,
      minMagenta: minMagenta,
      maxMagenta: maxMagenta,
      minYellow: minYellow,
      maxYellow: maxYellow,
      minBlack: minBlack,
      maxBlack: maxBlack,
    ));
  }
}
