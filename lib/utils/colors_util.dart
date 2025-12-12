import 'package:flutter/material.dart';

/// Color utilities for saturation, brightness, etc.
class ColorUtils {
  /// Returns a more saturated version of the given color.
  /// [amount] is how much to increase saturation (0.0 to 1.0).
  static Color saturate(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);
    return hsl
        .withSaturation((hsl.saturation + amount).clamp(0.0, 1.0))
        .toColor();
  }

  /// Optional: decrease saturation
  static Color desaturate(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);
    return hsl
        .withSaturation((hsl.saturation - amount).clamp(0.0, 1.0))
        .toColor();
  }

  /// Optional: lighten a color
  static Color lighten(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);
    return hsl
        .withLightness((hsl.lightness + amount).clamp(0.0, 1.0))
        .toColor();
  }

  /// Optional: darken a color
  static Color darken(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);
    return hsl
        .withLightness((hsl.lightness - amount).clamp(0.0, 1.0))
        .toColor();
  }

  static Color shiftHue(Color color, double degrees) {
    final hsl = HSLColor.fromColor(color);
    final double newHue = (hsl.hue + degrees) % 360;
    return hsl.withHue(newHue).toColor();
  }

  static Color transform(
    Color color, {
    double saturateAmount = 0.0,
    double darkenAmount = 0.0,
    double hueShift = 0.0, // in degrees
  }) {
    Color c = color;
    if (saturateAmount != 0) c = saturate(c, saturateAmount);
    if (darkenAmount != 0) c = darken(c, darkenAmount);
    if (hueShift != 0) c = shiftHue(c, hueShift);
    return c;
  }
}
