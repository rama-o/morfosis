import 'package:flutter/material.dart';
import 'colors_util.dart';

/// Centralized app colors that can be transformed dynamically.
class AppColors {
  final Color primary;
  final Color secondary;
  final Color tertiary;
  final Color background;
  final Color backgroundSecondary;
  final Color backgroundTertiary;
  final Color foreground;
  final Color bar;
  final Color disabled;
  final Color input;
  final Color success;
  final Color danger;
  final Color border;

  AppColors({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.background,
    required this.backgroundSecondary,
    required this.backgroundTertiary,
    required this.foreground,
    required this.bar,
    required this.disabled,
    required this.input,
    required this.success,
    required this.danger,
    required this.border,
  });

  /// Build from a ColorScheme (dynamic colors) or fallback scheme
  factory AppColors.fromScheme(ColorScheme scheme) {
    return AppColors(
      primary: ColorUtils.transform(
        scheme.primary,
        // saturateAmount: 0.1,
        // darkenAmount: 0.05,
        // hueShift: -40,
      ),
      secondary: ColorUtils.transform(
        scheme.secondary,
        saturateAmount: 0.3,
        darkenAmount: 0.05,
        hueShift: 20,
      ),
      tertiary: ColorUtils.transform(
        scheme.tertiary,
        // saturateAmount: 0.1,
        // hueShift: -40,
      ),
      background: const Color.fromARGB(255, 20, 20, 23), // your bgColor
      backgroundSecondary: const Color.fromARGB(255, 25, 25, 28),
      backgroundTertiary: ColorUtils.transform(
        scheme.tertiary,
        // saturateAmount: 0.1,
        darkenAmount: 0.55,
        // hueShift: -40,
      ),
      foreground: const Color(0xffcccccc), // your foregroundColor
      bar: const Color(0xFF14191D), // your barColor
      disabled: const Color(0xFF444444), // your disabledColor

      input: ColorUtils.transform(
        scheme.primary,
        saturateAmount: -0.2,
        darkenAmount: 0.5,
        // hueShift: -40,
      ),

      danger: const Color(0xffff8080),
      success: const Color.fromARGB(255, 206, 255, 128),
      border: const Color.fromARGB(255, 170, 170, 170),
    );
  }
}

/// Provide global access to colors
class ColorsProvider extends InheritedWidget {
  final AppColors colors;

  const ColorsProvider({required this.colors, required super.child});

  static AppColors of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ColorsProvider>()!.colors;

  @override
  bool updateShouldNotify(covariant ColorsProvider oldWidget) =>
      oldWidget.colors != colors;
}
