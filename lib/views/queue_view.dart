import 'dart:io';
import 'package:flutter/material.dart';
import '../widgets/empty_list.dart';
import '../widgets/list_item.dart';
import '../state/notifier.dart';
import '../widgets/button_secondary.dart';
import '../theme.dart';
import '../widgets/section_title.dart';
import '../utils/file_utils.dart';
import '../widgets/prompt_output.dart';

class QueueView extends StatelessWidget {
  final void Function(int) navigateTo;

  const QueueView({super.key, required this.navigateTo});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 8,
              children: [
                Expanded(child: SectionTitle(label: 'Queue')),
                CustomBtnSecondary(
                  glyph: const Icon(Icons.add),
                  tooltip: 'Add Files',
                  accent: accentColor,
                  action: () async {
                    await pickAudioOrVideo();
                  },
                ),
                CustomBtnSecondary(
                  glyph: const Icon(Icons.cleaning_services),
                  tooltip: 'Clear Queue',
                  accent: accentColor,
                  action: clearQueue,
                ),

                PopupMenuButton<int>(
                  color: bgColor2,
                  icon: const Icon(
                    Icons.settings,
                    size: 16,
                    color: accentColor,
                  ),
                  tooltip: 'Navigate to section',
                  onSelected: (int value) {
                    navigateTo(value);
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                    const PopupMenuItem<int>(
                      value: 1,
                      child: Text(
                        'Settings',
                        style: TextStyle(fontSize: 16, color: foregroundColor),
                      ),
                    ),
                    const PopupMenuItem<int>(
                      value: 2,
                      child: Text(
                        'About',
                        style: TextStyle(fontSize: 16, color: foregroundColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            ValueListenableBuilder<List<String>>(
              valueListenable: errorsNotifier,
              builder: (context, errors, _) {
                if (errorsNotifier.value.isEmpty) {
                  return const SizedBox(height: 0);
                }

                return PromptOutput(output: errorsNotifier.value);
              },
            ),

            ValueListenableBuilder<List<File>>(
              valueListenable: filesNotifier,
              builder: (context, files, _) {
                if (files.isEmpty) {
                  return const EmptyList();
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: files.length,
                  itemBuilder: (context, index) {
                    final file = files[index];
                    return ListItem(file: file, id: index);
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
