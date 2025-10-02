import 'dart:io';

class FileItem {
  File file;
  int progress;

  FileItem({required this.file, this.progress = 0});

  FileItem copyWith({
    File? file,
    int? progress,
  }) {
    return FileItem(
      file: file ?? this.file,
      progress: progress ?? this.progress,
    );
  }
}
