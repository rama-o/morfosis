import 'dart:async';
import 'package:file_picker/file_picker.dart';
import '../state/notifier.dart';
import '../models/file_item.dart';
import 'package:morfosis/utils/errors_utils.dart';
import 'package:path/path.dart' as p;
import './notifications.dart';

import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';

void addFile(String path) {
  final newItem = FileItem(path: path);
  final updatedFiles = [...filesNotifier.value, newItem];
  final uniqueFiles = {for (var f in updatedFiles) f.path: f}.values.toList();
  filesNotifier.value = uniqueFiles;
}

void removeFile(String path) {
  filesNotifier.value = filesNotifier.value
      .where((f) => f.path != path)
      .toList();
}

void clearQueue() {
  filesNotifier.value = [];
}

void updateProgress(String path, int progress) {
  for (final file in filesNotifier.value) {
    if (file.path == path) {
      file.updateProgress(progress);
      break;
    }
  }
}

void markFileDone(String path) {
  for (final file in filesNotifier.value) {
    if (file.path == path) {
      file.markDone();
      break;
    }
  }
}

Future<void> pickAudioOrVideo() async {
  isLoadingFiles.value = true;

  try {
    final result = await FilePicker.platform.pickFiles(
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
      final paths = result.files
          .where((pf) => pf.path != null)
          .map((pf) => pf.path!)
          .toList();
      addFiles(paths); // your existing function
    }
  } finally {
    isLoadingFiles.value = false; // hide spinner
  }
}

Future<void> addFiles(List<String> paths) async {
  if (paths.isEmpty) return;

  // Fetch current files
  final currentFiles = filesNotifier.value;

  // Use a map to ensure unique file paths
  final Map<String, FileItem> fileMap = {for (var f in currentFiles) f.path: f};

  // Add only new paths
  for (final path in paths) {
    if (!fileMap.containsKey(path)) {
      fileMap[path] = FileItem(path: path);
    }
  }

  // Update notifier once at the end (faster than multiple updates)
  filesNotifier.value = fileMap.values.toList();
}

Future<int> getMediaDuration(String path) async {
  // Run FFmpeg just to probe the file metadata
  final session = await FFmpegKit.execute('-i "$path"');
  final returnCode = await session.getReturnCode();

  if (!ReturnCode.isSuccess(returnCode)) {
    print('⚠️ Failed to read duration for: $path');
    return 0;
  }

  final logs = await session.getAllLogs();
  for (final log in logs) {
    final message = log.getMessage();

    final match = RegExp(
      r'Duration:\s(\d+):(\d+):(\d+\.\d+)',
    ).firstMatch(message);
    if (match != null) {
      final hours = int.parse(match.group(1)!);
      final minutes = int.parse(match.group(2)!);
      final seconds = double.parse(match.group(3)!);

      final totalMs = ((hours * 3600 + minutes * 60 + seconds) * 1000).toInt();
      return totalMs;
    }
  }

  print('⚠️ No duration found in FFmpeg output for: $path');
  return 0;
}

Future<void> convertFiles() async {
  clearErrors();

  // Notify user that conversion started
  await showNotification(
    'Conversion Started',
    'Please keep this app open and do not switch or close it.',
  );

  for (final fileItem in filesNotifier.value) {
    await _convertSingleFile(fileItem);
  }

  // Notify user that conversion finished
  await showNotification(
    'Conversion Complete',
    'All files have been successfully converted. You can find them in your Documents folder.',
  );
}

Future<void> _convertSingleFile(FileItem fileItem) async {
  final input = fileItem.path;
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
    settingsNotifier.value.overwrite ? '-y -i' : '-i',
    '"$input"',
    ...videoCodecOption,
    ...audioCodecOption,
    '"$output"',
  ];

  final command = commandList.join(' ');

  updateProgress(fileItem.path, 0);

  final duration = await getMediaDuration(input);

  final completer = Completer<void>();

  FFmpegKit.executeAsync(
    command,
    (session) async {
      final returnCode = await session.getReturnCode();

      if (ReturnCode.isSuccess(returnCode)) {
        markFileDone(fileItem.path);
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
        updateProgress(fileItem.path, progress);
      }
    },
  );

  return completer.future;
}
