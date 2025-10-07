import 'package:flutter/material.dart';
import '../theme.dart';
import '../state/notifier.dart';
import 'button_secondary.dart';
import '../utils/file_utils.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

class ListItem extends StatelessWidget {
  final int id;
  final File file;
  final int progress;

  const ListItem({
    super.key,
    required this.id,
    required this.file,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final String name = p.basenameWithoutExtension(file.path);
    final String inputFormat = p.extension(file.path).replaceFirst('.', '');

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor2,
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
                      style: TextStyle(color: foregroundColor, fontSize: 18),
                    ),
                    Text(
                      '$inputFormat → ${settingsNotifier.value.outputFormat}',
                      style: TextStyle(color: foregroundColor),
                    ),
                  ],
                ),
              ),

              progress == 100
                  ? Icon(Icons.check, color: succesColor, size: 24)
                  : Icon(Icons.schedule, color: Colors.grey, size: 24),

              CustomBtnSecondary(
                glyph: const Icon(Icons.delete),
                tooltip: 'Delete Item',
                accent: dangerColor,
                action: () {
                  removeFile(file);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
