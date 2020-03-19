import 'package:flutter/material.dart' show Color;
import 'package:color_models/color_models.dart' as cm;
import '../color_model.dart';
import './helpers/to_color.dart';

/// A color in the CIEXYZ color space.
class XyzColor extends cm.XyzColor with ToColor {
  /// A color in the CIEXYZ color space.
  ///
  /// [x], [y], and [z] must all be `>= 0`.
  ///
  /// The XYZ values have been normalized to a 0 to 100 range that
  /// represents the whole of the sRGB color space, but have been
  /// left upwardly unbounded to allow to allow for conversions
  /// between the XYZ and LAB color spaces that fall outside of
  /// the sRGB color space's bounds.
  XyzColor(
    num x,
    num y,
    num z, [
    num alpha = 1.0,
  ])  : assert(x != null && x >= 0),
        assert(y != null && y >= 0),
        assert(z != null && z >= 0),
        assert(alpha != null && alpha >= 0 && alpha <= 1),
        super(x, y, z, alpha);

  @override
  XyzColor withX(num x) {
    assert(x != null && x >= 0);

    return XyzColor(x, y, z, alpha);
  }

  @override
  XyzColor withY(num y) {
    assert(y != null && y >= 0);

    return XyzColor(x, y, z, alpha);
  }

  @override
  XyzColor withZ(num z) {
    assert(z != null && z >= 0);

    return XyzColor(x, y, z, alpha);
  }

  @override
  XyzColor withAlpha(num alpha) {
    assert(alpha != null && alpha >= 0 && alpha <= 1);

    return XyzColor(x, y, z, alpha);
  }

  /// Parses a list for XYZ values and returns a [XyzColor].
  ///
  /// [xyz] must not be null and must have exactly `3` or `4` values.
  ///
  /// [x] must be `>= 0` and `<= 95`.
  ///
  /// [y] must be `>= 0` and `<= 100`.
  ///
  /// [z] must be `>= 0` and `<= 109`.
  ///
  /// None of the color values may be null.
  static XyzColor fromList(List<num> xyz) {
    assert(xyz != null && (xyz.length == 3 || xyz.length == 4));
    assert(xyz[0] != null && xyz[0] >= 0 && xyz[0] <= 100);
    assert(xyz[1] != null && xyz[1] >= 0 && xyz[1] <= 100);
    assert(xyz[2] != null && xyz[2] >= 0 && xyz[2] <= 100);
    if (xyz.length == 4) {
      assert(xyz[3] != null && xyz[3] >= 0 && xyz[3] <= 1);
    }

    final alpha = xyz.length == 4 ? xyz[3] : 1.0;

    return XyzColor(xyz[0], xyz[1], xyz[2], alpha);
  }

  /// Returns [color] as a [XyzColor].
  static XyzColor fromColor(Color color) {
    assert(color != null);

    return RgbColor.fromColor(color).toXyzColor();
  }

  /// Returns a [color] in another color space as a XYZ color.
  static XyzColor from(ColorModel color) {
    assert(color != null);

    color = ToColor.cast(color);

    final xyz = cm.ColorConverter.toXyzColor(color);

    return XyzColor(xyz.x, xyz.y, xyz.z);
  }

  /// Returns a [hex] color as a CIEXYZ color.
  ///
  /// [hex] is case-insensitive and must be `3` or `6` characters
  /// in length, excluding an optional leading `#`.
  static XyzColor fromHex(String hex) {
    assert(hex != null);

    final xyz = cm.XyzColor.fromHex(hex);

    return XyzColor(xyz.x, xyz.y, xyz.z);
  }

  /// Returns a [XyzColor] from a list of [xyz] values on a 0 to 1 scale.
  ///
  /// [xyz] must not be null and must have exactly `3` or `4` values.
  ///
  /// Each of the values must be `>= 0` and `<= 1`.
  static XyzColor extrapolate(List<double> xyz) {
    assert(xyz != null && (xyz.length == 3 || xyz.length == 4));
    assert(xyz[0] != null && xyz[0] >= 0 && xyz[0] <= 1);
    assert(xyz[1] != null && xyz[1] >= 0 && xyz[1] <= 1);
    assert(xyz[2] != null && xyz[2] >= 0 && xyz[2] <= 1);
    if (xyz.length == 4) {
      assert(xyz[3] != null && xyz[3] >= 0 && xyz[3] <= 1);
    }

    final alpha = xyz.length == 4 ? xyz[3] : 1.0;

    return XyzColor(xyz[0] * 100, xyz[1] * 100, xyz[2] * 100, alpha);
  }
}
