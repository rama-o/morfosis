import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;
import '../state/settings_notifier.dart';

void addFile(File file) {
  final updatedFiles = [...filesNotifier.value, file];
  final uniqueFiles = {for (var f in updatedFiles) f.path: f}.values.toList();
  uniqueFiles.sort((a, b) => p.basename(a.path).compareTo(p.basename(b.path)));
  filesNotifier.value = uniqueFiles;
}

void removeFile(File file) {
  filesNotifier.value = filesNotifier.value.where((f) => f != file).toList();
}

void clearQueue() {
  filesNotifier.value = [];
}

Future<void> pickAudioOrVideo() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowMultiple: true,
    allowedExtensions: [
      'mp4', 'avi', 'mov', 'mpeg', 'mpg', 'flv', 'webm', 'wmv',
      'wma', 'mkv', 'mp3', 'm4a', 'wav', 'flac', 'ogg', 'aac', 'opus',
    ],
  );

  if (result != null) {
    for (var platformFile in result.files) {
      if (platformFile.path != null) {
        addFile(File(platformFile.path!));
      }
    }
  }
}
