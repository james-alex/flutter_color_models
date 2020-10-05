import 'package:color_models/color_models.dart' show ColorModel;
import 'package:flutter/painting.dart' show Color;
import '../../color_model.dart' show RgbColor;

/// Returns [color] as a [Color].
Color toColor(ColorModel color) {
  final rgb = RgbColor.from(color);
  return Color.fromARGB(rgb.alpha, rgb.red, rgb.green, rgb.blue);
}
