import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class CustomTextbox extends StatelessWidget {
  final TextEditingController ctrl;
  final ValueChanged<String> onChanged;
  final String label;

  const CustomTextbox({
    super.key,
    required this.ctrl,
    required this.onChanged,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ColorsProvider.of(context);

    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: colors.foreground)),
        TextField(
          controller: ctrl,
          style: TextStyle(color: colors.foreground),
          decoration: InputDecoration(
            filled: true,
            fillColor: colors.input,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
