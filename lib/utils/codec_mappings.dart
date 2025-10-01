import '../models/format_option.dart';

const videoFormats = [
  FormatOption(label: 'mp4', description: 'Most compatible video format'),
  FormatOption(label: 'avi', description: 'Legacy format, widely supported'),
  FormatOption(label: 'mov', description: 'Apple QuickTime format'),
  FormatOption(label: 'webm', description: 'Web-friendly format'),
  FormatOption(label: 'mkv', description: 'Advanced container, supports multiple codecs'),
  FormatOption(label: 'flv', description: 'Streaming format'),
  FormatOption(label: '3gp', description: 'Mobile-friendly, legacy phones'),
  FormatOption(label: '3g2', description: '3GPP2 format, CDMA networks'),
];

const audioFormats = [
  FormatOption(label: 'mp3', description: 'Most compatible audio format'),
  FormatOption(label: 'm4a', description: 'Apple-friendly audio format'),
  FormatOption(label: 'wav', description: 'Uncompressed audio'),
  FormatOption(label: 'flac', description: 'Lossless audio format'),
  FormatOption(label: 'ogg', description: 'Open source audio format'),
];

const videoCodecsArray = [
  FormatOption(label: 'Keep Original', description: 'Do not change the codec'),
  FormatOption(label: 'libx264', description: 'H.264 video, widely supported'),
  FormatOption(label: 'libx265', description: 'H.265/HEVC, smaller files, modern devices'),
  FormatOption(label: 'mpeg4', description: 'MPEG-4 Part 2, used in 3GP/3G2'),
  FormatOption(label: 'h263', description: 'H.263 codec, used in older 3GP/3G2'),
];

class VideoCodecs {
  static const keepOriginal = FormatOption(label: 'Keep Original', description: 'Do not change the codec');
  static const libx264 = FormatOption(label: 'libx264', description: 'H.264 video, widely supported');
  static const libx265 = FormatOption(label: 'libx265', description: 'H.265/HEVC, smaller files, modern devices');
  static const mpeg4 = FormatOption(label: 'mpeg4', description: 'MPEG-4 Part 2, used in 3GP/3G2');
  static const h263 = FormatOption(label: 'h263', description: 'H.263 codec, used in older 3GP/3G2');

  static const all = [
    keepOriginal,
    libx264,
    libx265,
    mpeg4,
    h263,
  ];
}

const audioCodecsArray = [
  FormatOption(label: 'Keep Original', description: 'Do not change the codec'),
  FormatOption(label: 'aac', description: 'Modern, widely supported audio codec'),
  FormatOption(label: 'ac3', description: 'Dolby Digital audio'),
  FormatOption(label: 'libmp3lame', description: 'MP3 audio codec'),
  FormatOption(label: 'flac', description: 'Lossless audio codec'),
  FormatOption(label: 'libopencore_amrnb', description: 'AMR Narrowband (3GP legacy)'),
  FormatOption(label: 'amr_wb', description: 'AMR Wideband (3GP legacy)'),
  FormatOption(label: 'pcm_s16le', description: 'WAV / uncompressed audio'),
];

class AudioCodecs {
  static const keepOriginal = FormatOption(label: 'Keep Original', description: 'Do not change the codec');
  static const aac = FormatOption(label: 'aac', description: 'Modern, widely supported audio codec');
  static const ac3 = FormatOption(label: 'ac3', description: 'Dolby Digital audio');
  static const libmp3lame = FormatOption(label: 'libmp3lame', description: 'MP3 audio codec');
  static const flac = FormatOption(label: 'flac', description: 'Lossless audio codec');
  static const libopencore_amrnb = FormatOption(label: 'libopencore_amrnb', description: 'AMR Narrowband (3GP legacy)');
  static const amr_wb = FormatOption(label: 'amr_wb', description: 'AMR Wideband (3GP legacy)');
  static const pcm_s16le = FormatOption(label: 'pcm_s16le', description: 'WAV / uncompressed audio');

  static const all = [
    keepOriginal,
    aac,
    ac3,
    libmp3lame,
    flac,
    libopencore_amrnb,
    amr_wb,
    pcm_s16le,
  ];
}

final Map<String, List<FormatOption>> formatToVideoCodecs = {
  'mp4': [VideoCodecs.keepOriginal, VideoCodecs.libx264, VideoCodecs.libx265],
  'avi': [VideoCodecs.keepOriginal, VideoCodecs.libx264],
  'mov': [VideoCodecs.keepOriginal, VideoCodecs.libx264, VideoCodecs.libx265],
  'webm': [VideoCodecs.keepOriginal, VideoCodecs.libx264],
  'mkv': [VideoCodecs.keepOriginal, VideoCodecs.libx264, VideoCodecs.libx265],
  'flv': [VideoCodecs.keepOriginal, VideoCodecs.libx264],
  '3gp': [VideoCodecs.keepOriginal, VideoCodecs.mpeg4, VideoCodecs.h263],
  '3g2': [VideoCodecs.keepOriginal, VideoCodecs.mpeg4, VideoCodecs.h263],
};

final Map<String, List<FormatOption>> formatToAudioCodecs = {
  'mp3': [AudioCodecs.keepOriginal, AudioCodecs.libmp3lame],
  'm4a': [AudioCodecs.keepOriginal, AudioCodecs.aac],
  'wav': [AudioCodecs.keepOriginal, AudioCodecs.pcm_s16le],
  'flac': [AudioCodecs.keepOriginal, AudioCodecs.flac],
  'ogg': [AudioCodecs.keepOriginal, AudioCodecs.aac],
  'mp4': [AudioCodecs.keepOriginal, AudioCodecs.aac, AudioCodecs.libmp3lame, AudioCodecs.ac3],
  'avi': [AudioCodecs.keepOriginal, AudioCodecs.libmp3lame, AudioCodecs.ac3, AudioCodecs.pcm_s16le],
  'mov': [AudioCodecs.keepOriginal, AudioCodecs.aac, AudioCodecs.libmp3lame, AudioCodecs.pcm_s16le],
  'webm': [AudioCodecs.keepOriginal, AudioCodecs.aac],
  'mkv': [AudioCodecs.keepOriginal, AudioCodecs.aac, AudioCodecs.ac3, AudioCodecs.libmp3lame, AudioCodecs.flac],
  'flv': [AudioCodecs.keepOriginal, AudioCodecs.aac, AudioCodecs.libmp3lame],
  '3gp': [AudioCodecs.keepOriginal, AudioCodecs.aac, AudioCodecs.libopencore_amrnb, AudioCodecs.amr_wb],
  '3g2': [AudioCodecs.keepOriginal, AudioCodecs.aac, AudioCodecs.libopencore_amrnb, AudioCodecs.amr_wb],
};

List<FormatOption> getVideoCodecsForFormat(String format) =>
    formatToVideoCodecs[format] ?? [VideoCodecs.keepOriginal];

List<FormatOption> getAudioCodecsForFormat(String format) =>
    formatToAudioCodecs[format] ?? [AudioCodecs.keepOriginal];
