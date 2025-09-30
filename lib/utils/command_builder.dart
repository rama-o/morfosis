import '../models/ui_settings.dart';

String buildComando(UiSettings settings) {
  String videoCodec = settings.videoCodec == 'Keep Original'
      ? ''
      : '-c:v ${settings.videoCodec}';
  String audioCodec = settings.audioCodec == 'Keep Original'
      ? ''
      : '-c:a ${settings.audioCodec}';

  return [
    'ffmpeg -i *',
    videoCodec,
    audioCodec,
    '${settings.outputPrefix}<fileName>${settings.outputSuffix}.${settings.outputFormat}',
  ].join(' ');
}
