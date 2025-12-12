import 'package:flutter/material.dart';
import 'button_primary.dart';
import '../utils/file_utils.dart';
import '../utils/app_colors.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ColorsProvider.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.backgroundSecondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.inbox, size: 48, color: colors.foreground),
          const SizedBox(height: 8),
          Text(
            "No files yet",
            style: TextStyle(fontSize: 18, color: colors.foreground),
          ),
          const SizedBox(height: 16),
          CustomBtnPrimary(
            glyph: const Icon(Icons.add),
            tooltip: 'Add Files',
            accent: colors.primary,
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
