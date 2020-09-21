import 'package:flutter/painting.dart' show Color;
import '../color_model.dart';

/// Returns [color] as a [Color].
Color toColor(ColorModel color) {
  final rgb = RgbColor.from(color);
  return Color.fromARGB(rgb.alpha, rgb.red, rgb.green, rgb.blue);
}
