import 'button.dart';

class CustomBtnSecondary extends CustomBtnBase {
  const CustomBtnSecondary({
    super.key,
    required super.glyph,
    required super.tooltip,
    required super.accent,
    required super.action,
    super.label,
  }) : super(isPrimary: false);
}