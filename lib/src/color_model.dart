import 'package:color_models/color_models.dart' as cm show ColorModel;
import 'package:flutter/painting.dart' show Color;
import 'package:meta/meta.dart';

export 'models/cmyk_color.dart';
export 'models/hsb_color.dart';
export 'models/hsi_color.dart';
export 'models/hsl_color.dart';
export 'models/hsp_color.dart';
export 'models/lab_color.dart';
export 'models/rgb_color.dart';
export 'models/xyz_color.dart';

@immutable
abstract class ColorModel implements cm.ColorModel, Color {
  /// Returns `this` as a [Color], converting the model to RGB if necessary.
  Color toColor();

  @override
  ColorModel withAlpha(int alpha);

  @override
  ColorModel withOpacity(double opacity);
}
