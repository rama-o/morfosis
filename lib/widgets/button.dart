import 'package:flutter/material.dart';
import '../theme.dart';

class CustomBtnBase extends StatelessWidget {
  final Icon glyph;
  final String tooltip;
  final Color accent;
  final VoidCallback action;
  final String? label;
  final bool isPrimary;

  const CustomBtnBase({
    super.key,
    required this.glyph,
    required this.tooltip,
    required this.accent,
    required this.action,
    this.label,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
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
              color: isPrimary ? bgColor : accent,
              size: glyph.size ?? 18,
            ),
          ),
        ),
      );
    }

    return TextButton.icon(
      style: TextButton.styleFrom(
        backgroundColor: isPrimary ? accent : Colors.transparent,
        foregroundColor: isPrimary ? bgColor : accent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
      onPressed: action,
      icon: glyph,
      label: Text(label!),
    );
  }
}
