import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class CustomBadge extends StatelessWidget {
  final String label;
  final IconData? icon;

  const CustomBadge({super.key, required this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    final colors = ColorsProvider.of(context);

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: colors.backgroundSecondary,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      child: Row(
        spacing: 16,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colors.backgroundTertiary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 22, color: colors.tertiary),
          ),
          Text(label, style: TextStyle(color: colors.tertiary)),
        ],
      ),
    );
  }
}
