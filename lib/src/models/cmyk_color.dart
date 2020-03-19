import 'package:flutter/material.dart' show Color;
import 'package:color_models/color_models.dart' as cm;
import '../color_model.dart';
import './helpers/to_color.dart';

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
  ]) :  assert(cyan != null && cyan >= 0 && cyan <= 100),
        assert(magenta != null && magenta >= 0 && magenta <= 100),
        assert(yellow != null && yellow >= 0 && yellow <= 100),
        assert(black != null && black >= 0 && black <= 100),
        assert(alpha != null && alpha >= 0 && alpha <= 1),
        super(cyan, magenta, yellow, black, alpha);

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

  /// Parses a list for CMYK values and returns a [CmykColor].
  ///
  /// [cmyk] must not be null and must have exactly `4` or `5` values.
  ///
  /// Each color value must be `>= 0 && <= 100`.
  static CmykColor fromList(List<num> cmyk) {
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

  /// Returns [color] as a [CmykColor].
  static CmykColor fromColor(Color color) {
    assert(color != null);

    return RgbColor.fromColor(color).toCmykColor();
  }

  /// Returns a [color] in another color space as a CMYK color.
  static CmykColor from(ColorModel color) {
    assert(color != null);

    color = ToColor.cast(color);

    final cmyk = cm.ColorConverter.toCmykColor(color);

    return CmykColor(cmyk.cyan, cmyk.magenta, cmyk.yellow, cmyk.black);
  }

  /// Returns a [hex] color as a CMYK color.
  ///
  /// [hex] is case-insensitive and must be `3` or `6` characters
  /// in length, excluding an optional leading `#`.
  static CmykColor fromHex(String hex) {
    assert(hex != null);

    final cmyk = cm.CmykColor.fromHex(hex);

    return CmykColor(cmyk.cyan, cmyk.magenta, cmyk.yellow, cmyk.black);
  }

  /// Returns a [CmykColor] from a list of [cmyk] values on a 0 to 1 scale.
  ///
  /// [cmyk] must not be null and must have exactly `4` or `5` values.
  ///
  /// Each of the values must be `>= 0` and `<= 1`.
  static CmykColor extrapolate(List<double> cmyk) {
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
}
