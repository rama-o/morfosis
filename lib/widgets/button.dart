import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class CustomBtnBase extends StatelessWidget {
  final Icon glyph;
  final String tooltip;
  final Color? accent;
  final VoidCallback action;
  final String? label;
  final bool isPrimary;

  const CustomBtnBase({
    super.key,
    required this.glyph,
    required this.tooltip,
    this.accent,
    required this.action,
    this.label,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ColorsProvider.of(context);

    if (label == null) {
      return Tooltip(
        message: tooltip,
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: action,
          child: Container(
            decoration: BoxDecoration(
              color: isPrimary ? accent : Colors.transparent,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(12),
            child: Icon(
              glyph.icon,
              color: isPrimary ? colors.background : accent,
              size: glyph.size ?? 18,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      child: TextButton.icon(
        style: TextButton.styleFrom(
          backgroundColor: isPrimary ? colors.primary : Colors.transparent,
          foregroundColor: isPrimary ? colors.background : colors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onPressed: action,
        icon: glyph,
        label: Text(label!),
      ),
    );
  }
}
