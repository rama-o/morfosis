import 'package:flutter/foundation.dart';

class FileItem {
  final String path;
  final ValueNotifier<int> progressNotifier;

  FileItem({required this.path, int progress = 0})
    : progressNotifier = ValueNotifier(progress);

  int get progress => progressNotifier.value;

  void updateProgress(int newProgress) {
    if (progressNotifier.value != newProgress) {
      progressNotifier.value = newProgress;
    }
  }

  void markDone() {
    updateProgress(100);
  }
}
