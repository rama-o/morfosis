import 'dart:io';
import 'dart:async';
import 'package:file_picker/file_picker.dart';
import '../state/notifier.dart';
import '../models/file_item.dart';
import 'package:morfosis/utils/errors_utils.dart';
import 'package:path/path.dart' as p;

import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';

void addFile(File file) {
  final newItem = FileItem(file: file);
  final updatedFiles = [...filesNotifier.value, newItem];
  final uniqueFiles = {
    for (var f in updatedFiles) f.file.path: f,
  }.values.toList();
  // uniqueFiles
  // .sort(
  //   (a, b) => p.basename(a.file.path).compareTo(p.basename(b.file.path)),
  // );
  filesNotifier.value = uniqueFiles;
}

void removeFile(File file) {
  filesNotifier.value = filesNotifier.value
      .where((f) => f.file.path != file.path)
      .toList();
}

void clearQueue() {
  filesNotifier.value = [];
}

void updateProgress(String filePath, int progress) {
  final updatedFiles = filesNotifier.value
      .map(
        (fileItem) => fileItem.file.path == filePath
            ? fileItem.copyWith(progress: progress)
            : fileItem,
      )
      .toList();

  filesNotifier.value = [...updatedFiles];
}

void markFileDone(String filePath) {
  final updatedFiles = filesNotifier.value
      .map(
        (fileItem) => fileItem.file.path == filePath
            ? fileItem.copyWith(progress: 100)
            : fileItem,
      )
      .toList();

  filesNotifier.value = [...updatedFiles];
}

Future<void> pickAudioOrVideo() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowMultiple: true,
    allowedExtensions: [
      'mp4',
      'avi',
      'mov',
      'mpeg',
      'mpg',
      'flv',
      'webm',
      'wmv',
      'm4v',
      'rm',
      'rmvb',
      'vob',
      'mts',
      'm2ts',
      'ts',
      'f4v',
      'divx',
      '3gp',
      '3g2',

      'wma',
      'mkv',
      'mp3',
      'm4a',
      'wav',
      'flac',
      'ogg',
      'aac',
      'opus',
      'amr',
      'aiff',
      'aif',
      'au',
      'ra',
      'mid',
      'midi',
      'caf',
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

Future<int> getMediaDuration(String filePath) async {
  final session = await FFmpegKit.execute('-i "$filePath"');
  final returnCode = await session.getReturnCode();
  if (!ReturnCode.isSuccess(returnCode)) return 0;

  final logs = await session.getAllLogs();
  for (var log in logs) {
    final message = log.getMessage();
    final match = RegExp(
      r'Duration: (\d+):(\d+):(\d+\.\d+)',
    ).firstMatch(message);
    if (match != null) {
      final hours = int.parse(match.group(1)!);
      final minutes = int.parse(match.group(2)!);
      final seconds = double.parse(match.group(3)!);
      return ((hours * 3600 + minutes * 60 + seconds) * 1000).toInt();
    }
  }

  return 0;
}

Future<void> convertFiles() async {
  clearErrors();

  for (final fileItem in filesNotifier.value) {
    await _convertSingleFile(fileItem);
  }
}

Future<void> _convertSingleFile(FileItem fileItem) async {
  final input = fileItem.file.path;
  final name = p.basenameWithoutExtension(input);

  final output = p.join(
    'storage',
    'emulated',
    '0',
    'Documents',
    '${settingsNotifier.value.outputPrefix}$name${settingsNotifier.value.outputSuffix}.${settingsNotifier.value.outputFormat}',
  );

  final videoCodecOption = settingsNotifier.value.videoCodec != 'Keep Original'
      ? ['-c:v', settingsNotifier.value.videoCodec]
      : [];
  final audioCodecOption = settingsNotifier.value.audioCodec != 'Keep Original'
      ? ['-c:a', settingsNotifier.value.audioCodec]
      : [];

  final commandList = [
    settingsNotifier.value.overwrite ? '-i -y' : '-i',
    '"$input"',
    ...videoCodecOption,
    ...audioCodecOption,
    '"$output"',
  ];

  final command = commandList.join(' ');

  updateProgress(fileItem.file.path, 0);

  final duration = await getMediaDuration(input);

  final completer = Completer<void>();

  FFmpegKit.executeAsync(
    command,
    (session) async {
      final returnCode = await session.getReturnCode();

      if (ReturnCode.isSuccess(returnCode)) {
        markFileDone(fileItem.file.path);
        print('✅ Conversion finished: $output');
      } else {
        addError('❌ Conversion failed for $input (code $returnCode)');
      }

      completer.complete();
    },
    (log) {
      print(log.getMessage());
    },
    (statistics) {
      if (duration > 0) {
        final time = statistics.getTime();
        final progress = ((time / duration) * 100).clamp(0, 100).toInt();
        updateProgress(fileItem.file.path, progress);
      }
    },
  );

  return completer.future;
}
