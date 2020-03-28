import 'package:flutter/material.dart' show Color;
import '../color_model.dart';

/// Returns [color] as a [Color].
Color toColor(ColorModel color) {
  final rgb = RgbColor.from(color);
  return Color.fromRGBO(rgb.red, rgb.green, rgb.blue, rgb.alpha);
}
