import 'package:flutter/material.dart';
import '../theme.dart';

class CustomBadge extends StatelessWidget {
  final String label;
  final IconData? icon;
  final double iconSize;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final EdgeInsets padding;
  final double borderRadius;

  const CustomBadge({
    super.key,
    required this.label,
    this.icon,
    this.iconSize = 22,
    this.textStyle,
    this.backgroundColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    final Color bg = backgroundColor ?? accentColor;
    final TextStyle style =
        textStyle ??
        const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        );

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: iconSize, color: style.color),
            const SizedBox(width: 4),
          ],
          Text(label, style: style),
        ],
      ),
    );
  }
}