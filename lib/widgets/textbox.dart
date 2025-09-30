import 'package:flutter/material.dart';
import '../theme.dart';

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
    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: foregroundColor)),
        TextField(
          controller: ctrl,
          style: const TextStyle(color: foregroundColor),
          decoration: InputDecoration(
            filled: true,
            fillColor: inputColor,
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