import '../state/notifier.dart';
import 'package:path/path.dart' as p;

String buildComando() {
  final videoCodec = settingsNotifier.value.videoCodec == 'Keep Original'
      ? ''
      : '-c:v ${settingsNotifier.value.videoCodec}';
  final audioCodec = settingsNotifier.value.audioCodec == 'Keep Original'
      ? ''
      : '-c:a ${settingsNotifier.value.audioCodec}';

  final output = p.join(
    'storage',
    'emulated',
    '0',
    'Documents',
    '${settingsNotifier.value.outputPrefix}<FILE_NAME>${settingsNotifier.value.outputSuffix}.${settingsNotifier.value.outputFormat}',
  );

  return [
    'ffmpeg -i <FILE_PATH>',
    videoCodec,
    audioCodec,
    '"${output}"',
  ].where((e) => e.isNotEmpty).join(' ');
}
