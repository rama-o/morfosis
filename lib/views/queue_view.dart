import 'package:flutter/material.dart';
import '../widgets/empty_list.dart';
import '../widgets/list_item.dart';
import '../state/notifier.dart';
import '../widgets/button_secondary.dart';
import '../theme.dart';
import '../widgets/section_title.dart';
import '../utils/file_utils.dart';
import '../widgets/prompt_output.dart';
import '../models/file_item.dart';

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
            // Header Row
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

            // Errors Section
            ValueListenableBuilder<List<String>>(
              valueListenable: errorsNotifier,
              builder: (context, errors, _) {
                if (errors.isEmpty) return const SizedBox.shrink();
                return PromptOutput(output: errors);
              },
            ),

            // Loading Spinner or File List
            ValueListenableBuilder<bool>(
              valueListenable: isLoadingFiles,
              builder: (context, loading, _) {
                if (loading) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: CircularProgressIndicator(color: accentColor2),
                    ),
                  );
                }

                // File List
                return ValueListenableBuilder<List<FileItem>>(
                  valueListenable: filesNotifier,
                  builder: (context, fileItems, _) {
                    if (fileItems.isEmpty) return const EmptyList();

                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: fileItems.length,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final fileItem = fileItems[index];
                        return ListItem(
                          id: index,
                          path: fileItem.path,
                          progress: fileItem.progress,
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
