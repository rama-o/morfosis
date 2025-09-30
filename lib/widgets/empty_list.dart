import 'package:flutter/material.dart';
import '../theme.dart';
import 'button_primary.dart';
import '../utils/file_utils.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor2,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.inbox, size: 48, color: Colors.grey),
          const SizedBox(height: 8),
          Text(
            "No files yet",
            style: TextStyle(fontSize: 18, color: Colors.grey[400]),
          ),
          const SizedBox(height: 16),
          CustomBtnPrimary(
            glyph: const Icon(Icons.add),
            tooltip: 'Add Files',
            accent: accentColor,
            label: 'Add Files',
            action: () async {
              await pickAudioOrVideo();
            },
          ),
        ],
      ),
    );
  }
}