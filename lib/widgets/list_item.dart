import 'package:flutter/material.dart';
import '../theme.dart';
import '../state/settings_notifier.dart';
import 'button_secondary.dart';
import '../utils/file_utils.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

class ListItem extends StatelessWidget {
  final int id;
  final File file;

  const ListItem({super.key, required this.id, required this.file});

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
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 16,
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
