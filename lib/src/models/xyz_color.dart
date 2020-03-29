import 'package:flutter/material.dart' show Color;
import 'package:color_models/color_models.dart' as cm;
import '../color_model.dart';
import '../helpers/to_color.dart';

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
  const XyzColor(
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
  List<XyzColor> interpolateTo(
    ColorModel color,
    int steps, {
    bool excludeOriginalColors = false,
  }) {
    assert(color != null);
    assert(steps != null && steps > 0);
    assert(excludeOriginalColors != null);

    final colors = ToColor.cast(this).interpolateTo(ToColor.cast(color), steps,
        excludeOriginalColors: excludeOriginalColors);

    return List<XyzColor>.from(colors.map(ToColor.cast));
  }

  @override
  XyzColor get inverted => ToColor.cast(ToColor.cast(this).inverted);

  @override
  XyzColor get opposite => rotateHue(180);

  @override
  XyzColor rotateHue(num amount) {
    assert(amount != null);

    final hslColor = toHslColor();

    return hslColor.withHue((hslColor.hue + amount) % 360).toXyzColor();
  }

  @override
  XyzColor warmer(num amount, {bool relative = true}) {
    assert(amount != null && amount > 0);
    assert(relative != null);

    return ToColor.cast(ToColor.cast(this).warmer(amount, relative: relative));
  }

  @override
  XyzColor cooler(num amount, {bool relative = true}) {
    assert(amount != null && amount > 0);
    assert(relative != null);

    return ToColor.cast(ToColor.cast(this).cooler(amount, relative: relative));
  }

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

  /// Returns this [XyzColor] modified with the provided [hue] value.
  @override
  XyzColor withHue(num hue) {
    assert(hue != null && hue >= 0 && hue <= 360);

    final hslColor = toHslColor();

    return hslColor.withHue((hslColor.hue + hue) % 360).toXyzColor();
  }

  @override
  XyzColor toXyzColor() => this;

  /// Constructs a [XyzColor] from [color].
  factory XyzColor.from(ColorModel color) {
    assert(color != null);

    color = ToColor.cast(color);

    final xyz = cm.ColorConverter.toXyzColor(color);

    return XyzColor(xyz.x, xyz.y, xyz.z);
  }

  /// Constructs a [XyzColor] from a list of [xyz] values.
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
  factory XyzColor.fromList(List<num> xyz) {
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

  /// Constructs a [XyzColor] from [color].
  factory XyzColor.fromColor(Color color) {
    assert(color != null);

    return RgbColor.fromColor(color).toXyzColor();
  }

  /// Constructs a [XyzColor] from a [hex] color.
  ///
  /// [hex] is case-insensitive and must be `3` or `6` characters
  /// in length, excluding an optional leading `#`.
  factory XyzColor.fromHex(String hex) {
    assert(hex != null);

    final xyz = cm.XyzColor.fromHex(hex);

    return XyzColor(xyz.x, xyz.y, xyz.z);
  }

  /// Constructs a [XyzColor] from a list of [xyz] values on a `0` to `1` scale.
  ///
  /// [xyz] must not be null and must have exactly `3` or `4` values.
  ///
  /// Each of the values must be `>= 0` and `<= 1`.
  factory XyzColor.extrapolate(List<double> xyz) {
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

  /// Generates a [XyzColor] at random.
  ///
  /// [minX] and [maxX] constrain the generated [x] value.
  ///
  /// [minY] and [maxY] constrain the generated [y] value.
  ///
  /// [minZ] and [maxZ] constrain the generated [z] value.
  ///
  /// All min and max values must be `min <= max && max >= min`, must be
  /// in the range of `>= 0 && <= 100`, and must not be `null`.
  factory XyzColor.random({
    num minX = 0,
    num maxX = 100,
    num minY = 0,
    num maxY = 100,
    num minZ = 0,
    num maxZ = 100,
  }) {
    assert(minX != null && minX >= 0 && minX <= maxX);
    assert(maxX != null && maxX >= minX && maxX <= 100);
    assert(minY != null && minY >= 0 && minY <= maxY);
    assert(maxY != null && maxY >= minY && maxY <= 100);
    assert(minZ != null && minZ >= 0 && minZ <= maxZ);
    assert(maxZ != null && maxZ >= minZ && maxZ <= 100);

    return ToColor.cast(cm.XyzColor.random(
      minX: minX,
      maxX: maxX,
      minY: minY,
      maxY: maxY,
      minZ: minZ,
      maxZ: maxZ,
    ));
  }
}
