import '../models/format_option.dart';

const videoFormats = [
  FormatOption(label: 'mp4', description: 'Most compatible video format'),
  FormatOption(label: 'avi', description: 'Legacy format, widely supported'),
  FormatOption(label: 'mov', description: 'Apple QuickTime format'),
  FormatOption(label: 'webm', description: 'Web-friendly format'),
  FormatOption(label: 'mkv', description: 'Advanced container, supports multiple codecs'),
  FormatOption(label: 'flv', description: 'Streaming format'),
];

const audioFormats = [
  FormatOption(label: 'mp3', description: 'Most compatible audio format'),
  FormatOption(label: 'm4a', description: 'Apple-friendly audio format'),
  FormatOption(label: 'wav', description: 'Uncompressed audio'),
  FormatOption(label: 'flac', description: 'Lossless audio format'),
  FormatOption(label: 'ogg', description: 'Open source audio format'),
];

const videoCodecs = [
  FormatOption(label: 'Keep Original', description: 'Do not change the codec'),
  FormatOption(label: 'libx264', description: 'H.264 video, widely supported'),
  FormatOption(label: 'libx265', description: 'H.265/HEVC, smaller files, modern devices'),
];

const audioCodecs = [
  FormatOption(label: 'Keep Original', description: 'Do not change the codec'),
  FormatOption(label: 'aac', description: 'Modern, widely supported audio codec'),
  FormatOption(label: 'ac3', description: 'Dolby Digital audio'),
  FormatOption(label: 'libmp3lame', description: 'MP3 audio codec'),
  FormatOption(label: 'flac', description: 'Lossless audio codec'),
];

final Map<String, List<FormatOption>> formatToVideoCodecs = {
  'mp4': [videoCodecs[0], videoCodecs[1], videoCodecs[2]],
  'avi': [videoCodecs[0], videoCodecs[1]],
  'mov': [videoCodecs[0], videoCodecs[1], videoCodecs[2]],
  'webm': [videoCodecs[0], videoCodecs[1]],
  'mkv': [videoCodecs[0], videoCodecs[1], videoCodecs[2]],
  'flv': [videoCodecs[0], videoCodecs[1]],
};

final Map<String, List<FormatOption>> formatToAudioCodecs = {
  'mp3': [audioCodecs[0], audioCodecs[3]],
  'm4a': [audioCodecs[0], audioCodecs[1]],
  'wav': [audioCodecs[0]],
  'flac': [audioCodecs[0], audioCodecs[4]],
  'ogg': [audioCodecs[0], audioCodecs[1]],
};

List<FormatOption> getVideoCodecsForFormat(String format) {
  return formatToVideoCodecs[format] ?? [videoCodecs[0]];
}

List<FormatOption> getAudioCodecsForFormat(String format) {
  return formatToAudioCodecs[format] ?? [audioCodecs[0]];
}
