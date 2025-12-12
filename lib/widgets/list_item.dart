import 'package:flutter/material.dart';
// import '../theme.dart';
import '../state/notifier.dart';
import 'button_secondary.dart';
import '../utils/file_utils.dart';
import 'package:path/path.dart' as p;
import '../utils/app_colors.dart';

class ListItem extends StatelessWidget {
  final int id;
  final String path;
  final int progress;

  const ListItem({
    super.key,
    required this.id,
    required this.path,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ColorsProvider.of(context);
    final name = p.basenameWithoutExtension(path);
    final inputFormat = p.extension(path).replaceFirst('.', '');

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.backgroundSecondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(color: colors.foreground, fontSize: 18),
                    ),
                    Text(
                      '$inputFormat → ${settingsNotifier.value.outputFormat}',
                      style: TextStyle(color: colors.foreground),
                    ),
                  ],
                ),
              ),
              progress == 100
                  ? Icon(Icons.check, color: colors.success, size: 24)
                  : Icon(Icons.schedule, color: colors.disabled, size: 24),
              CustomBtnSecondary(
                glyph: const Icon(Icons.delete),
                tooltip: 'Delete Item',
                accent: colors.danger,
                action: () => removeFile(path),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
