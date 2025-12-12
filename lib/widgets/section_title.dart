import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class SectionTitle extends StatelessWidget {
  final String label;

  const SectionTitle({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final colors = ColorsProvider.of(context);

    return Text(
      label,
      style: TextStyle(color: colors.foreground, fontSize: 28),
    );
  }
}
