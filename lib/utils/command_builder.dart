import '../models/ui_settings.dart';
import '../state/settings_notifier.dart';

String buildComando() {
  String videoCodec = settingsNotifier.value.videoCodec == 'Keep Original'
      ? ''
      : '-c:v ${settingsNotifier.value.videoCodec}';
  String audioCodec = settingsNotifier.value.audioCodec == 'Keep Original'
      ? ''
      : '-c:a ${settingsNotifier.value.audioCodec}';

  return [
    'ffmpeg -i <filePath>',
    videoCodec,
    audioCodec,
    '${settingsNotifier.value.outputPrefix}<fileName>${settingsNotifier.value.outputSuffix}.${settingsNotifier.value.outputFormat}',
  ].join(' ');
}
