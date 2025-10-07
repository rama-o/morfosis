class FileItem {
  final String path;
  final int progress;

  FileItem({required this.path, this.progress = 0});

  FileItem copyWith({String? path, int? progress}) {
    return FileItem(
      path: path ?? this.path,
      progress: progress ?? this.progress,
    );
  }
}