import '../state/notifier.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

Future<String> buildComando() async {
  final downloadsDir = Directory('/storage/emulated/0/Download/Morfosis');

  final videoCodec = settingsNotifier.value.videoCodec == 'Keep Original'
      ? ''
      : '-c:v ${settingsNotifier.value.videoCodec}';
  final audioCodec = settingsNotifier.value.audioCodec == 'Keep Original'
      ? ''
      : '-c:a ${settingsNotifier.value.audioCodec}';

  final output = p.join(
    downloadsDir.path,
    '${settingsNotifier.value.outputPrefix}<FILE_NAME>${settingsNotifier.value.outputSuffix}.${settingsNotifier.value.outputFormat}',
  );

  return [
    'ffmpeg',
    settingsNotifier.value.overwrite ? '-y -i' : '-i',
    '<FILE_PATH>',
    videoCodec,
    audioCodec,
    '"$output"',
  ].where((e) => e.isNotEmpty).join(' ');
}
