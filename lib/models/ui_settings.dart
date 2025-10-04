class UiSettings {
  String outputFormat;
  String videoCodec;
  String audioCodec;
  String outputPrefix;
  String outputSuffix;
  bool overwrite;

  UiSettings({
    this.outputFormat = 'mp3',
    this.videoCodec = 'Keep Original',
    this.audioCodec = 'Keep Original',
    this.outputPrefix = 'mor_',
    this.outputSuffix = '',
    this.overwrite = true,
  });

  UiSettings copyWith({
    String? outputFormat,
    String? videoCodec,
    String? audioCodec,
    String? outputPrefix,
    String? outputSuffix,
    String? command,
    bool? overwrite,
  }) {
    return UiSettings(
      outputFormat: outputFormat ?? this.outputFormat,
      videoCodec: videoCodec ?? this.videoCodec,
      audioCodec: audioCodec ?? this.audioCodec,
      outputPrefix: outputPrefix ?? this.outputPrefix,
      outputSuffix: outputSuffix ?? this.outputSuffix,
      overwrite: overwrite ?? this.overwrite,
    );
  }
}
