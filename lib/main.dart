import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

void main() {
  runApp(const MorfosisApp());
}

const Color bgColor = Color.fromARGB(255, 20, 20, 20);
const Color bgColor2 = Color.fromARGB(255, 25, 25, 25);
const Color barColor = Color.fromARGB(255, 20, 25, 29);
const Color detailsColor = Color.fromARGB(255, 150, 128, 233);
const Color dangerColor = Color(0xffff8080);
const Color foregroundColor = Color(0xffcccccc);
const Color inputColor = Color.fromARGB(255, 118, 190, 140);
const Color uncheckedColor = Color(0xFF386A68);
const Color checkedColor = Color(0xFF689896);

class UiSettings {
  String outputFormat;

  String videoCodec;

  String audioCodec;

  String outputPrefix;
  String outputSuffix;

  UiSettings({
    this.outputFormat = 'mp4',
    this.videoCodec = 'libx264',
    this.audioCodec = 'ac3',
    this.outputPrefix = '',
    this.outputSuffix = '.copy',
  });

  UiSettings copyWith({
    String? outputFormat,
    String? videoCodec,
    String? audioCodec,
    String? outputPrefix,
    String? outputSuffix,
  }) {
    return UiSettings(
      outputFormat: outputFormat ?? this.outputFormat,
      videoCodec: videoCodec ?? this.videoCodec,
      audioCodec: audioCodec ?? this.audioCodec,
      outputPrefix: outputPrefix ?? this.outputPrefix,
      outputSuffix: outputSuffix ?? this.outputSuffix,
    );
  }
}

final ValueNotifier<UiSettings> settingsNotifier = ValueNotifier(UiSettings());

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

const formatList = [
  'mp4',
  'avi',
  'webm',
  'wmv',
  'mov',
  'mpeg',
  'ogg',
  'mp3',
  'm4a',
  'wav',
  'wma',
  'flac',
];

const videoCodecList = ['Keep Original', 'libx264'];

const audioCodecList = ['Keep Original', 'acc', 'ac3', 'mp3lame'];

const queue = [
  '/home/alejandro video.wmv',
  '/home/juana camacho visitando los sobrinos de santa fe.avi',
];

final suffixController = TextEditingController(
  text: settingsNotifier.value.outputSuffix,
);

final prefixController = TextEditingController(
  text: settingsNotifier.value.outputPrefix,
);

class SectionTitle extends StatelessWidget {
  final String label;

  const SectionTitle({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(label, style: TextStyle(color: foregroundColor, fontSize: 28));
  }
}

class CustomBtnSecondary extends StatelessWidget {
  final Icon glyph;
  final String tooltip;
  final Color bg;
  final VoidCallback action;

  const CustomBtnSecondary({
    super.key,
    required this.glyph,
    required this.tooltip,
    required this.bg,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        icon: glyph,
        tooltip: tooltip,
        color: bg,
        onPressed: action,
      ),
    );
  }
}

class CustomBtnPrimary extends StatelessWidget {
  final Icon glyph;
  final String tooltip;
  final Color bg;
  final VoidCallback action;

  const CustomBtnPrimary({
    super.key,
    required this.glyph,
    required this.tooltip,
    required this.bg,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(25),
      ),
      child: IconButton(
        icon: glyph,
        tooltip: tooltip,
        color: bgColor,
        onPressed: action,
      ),
    );
  }
}

class CustomRadio extends StatelessWidget {
  final String value;
  final String Function(UiSettings) selector;
  final UiSettings Function(UiSettings, String) updater;

  const CustomRadio({
    super.key,
    required this.value,
    required this.selector,
    required this.updater,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<UiSettings>(
      valueListenable: settingsNotifier,
      builder: (context, settings, _) {
        final groupValue = selector(settings);
        return RadioListTile<String>(
          title: Text(value, style: TextStyle(color: foregroundColor)),
          value: value,
          groupValue: groupValue,
          onChanged: (val) {
            if (val != null) {
              settingsNotifier.value = updater(settings, val);
            }
          },
          fillColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.selected)) return checkedColor;
            return uncheckedColor;
          }),
        );
      },
    );
  }
}

class CodeInput extends StatelessWidget {
  final String output;

  const CodeInput({super.key, required this.output});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 27, 35, 51),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(output, style: TextStyle(color: Color(0xffffe23e))),
    );
  }
}

class PromptOutput extends StatelessWidget {
  final List<String> output;

  const PromptOutput({super.key, required this.output});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: output
          .map<Widget>(
            (err) => Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xff382929),
                border: Border.all(color: const Color(0xffa13030)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                err,
                style: const TextStyle(color: Color(0xffffa5aa)),
              ),
            ),
          )
          .toList(),
    );
  }
}

class ListItem extends StatelessWidget {
  final int id;
  final String path;

  const ListItem({super.key, required this.id, required this.path});

  @override
  Widget build(BuildContext context) {
    final String name = p.basenameWithoutExtension(path);
    // final String inputFormat = p.extension(path).replaceFirst('.', '');

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor2,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: TextStyle(color: foregroundColor, fontSize: 18)),
          Row(
            spacing: 16,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 61, 61, 61),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    '100%',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: foregroundColor),
                  ),
                ),
              ),
              // Container(
              //   padding: const EdgeInsets.all(8),
              //   decoration: BoxDecoration(
              //     color: const Color.fromARGB(255, 12, 141, 141),
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: Text(
              //     inputFormat,
              //     style: TextStyle(color: foregroundColor),
              //   ),
              // ),
              // Container(
              //   padding: const EdgeInsets.all(8),
              //   decoration: BoxDecoration(
              //     color: const Color(0xff1279b1),
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: Text(
              //     settingsNotifier.value.outputFormat,
              //     style: TextStyle(color: foregroundColor),
              //   ),
              // ),
              CustomBtnSecondary(
                glyph: const Icon(Icons.delete),
                tooltip: 'Delete Item',
                bg: dangerColor,

                action: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MorfosisApp extends StatefulWidget {
  const MorfosisApp({super.key});

  @override
  State<MorfosisApp> createState() => _MorfosisAppState();
}

class _MorfosisAppState extends State<MorfosisApp> {
  final PageController _pageController = PageController();

  int currentViewIndex = 0;
  bool changeFormat = true;

  List<String> errors = [];

  void navigateTo(int index) {
    setState(() => currentViewIndex = index);
    _pageController.jumpToPage(index);
  }

  void addFiles() {}
  void convertFiles() {}
  void clearQueue() {}
  void deleteItem() {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: bgColor,
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => currentViewIndex = index);
          },
          children: [
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: 8,
                      children: [
                        Expanded(child: SectionTitle(label: 'Queue')),
                        CustomBtnSecondary(
                          glyph: const Icon(Icons.add),
                          tooltip: 'Add Files',
                          bg: detailsColor,

                          action: addFiles,
                        ),
                        CustomBtnSecondary(
                          glyph: const Icon(Icons.cleaning_services),
                          tooltip: 'Clear Queue',
                          bg: detailsColor,

                          action: clearQueue,
                        ),
                        CustomBtnSecondary(
                          glyph: const Icon(Icons.settings),
                          tooltip: 'Settings',
                          bg: detailsColor,

                          action: () => navigateTo(1),
                        ),
                      ],
                    ),

                    if (!errors.isEmpty) PromptOutput(output: errors),

                    Column(
                      spacing: 16,
                      children: queue
                          .map(
                            (item) =>
                                ListItem(path: item, id: queue.indexOf(item)),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),

            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: 8,
                      children: [
                        Expanded(child: SectionTitle(label: 'Settings')),
                        CustomBtnSecondary(
                          glyph: const Icon(Icons.autorenew),
                          tooltip: 'Reset Settings',
                          bg: detailsColor,

                          action: clearQueue,
                        ),
                        CustomBtnSecondary(
                          glyph: const Icon(Icons.close),
                          tooltip: 'Close Settings',
                          bg: detailsColor,

                          action: () => navigateTo(0),
                        ),
                      ],
                    ),

                    if (!errors.isEmpty) PromptOutput(output: errors),

                    Text(
                      'Format',
                      style: TextStyle(color: foregroundColor, fontSize: 18),
                    ),

                    Container(
                      decoration: BoxDecoration(
                        color: bgColor2,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: formatList.map((format) {
                          return CustomRadio(
                            value: format,
                            selector: (settings) => settings.outputFormat,
                            updater: (settings, val) =>
                                settings.copyWith(outputFormat: val),
                          );
                        }).toList(),
                      ),
                    ),

                    Text(
                      'Video Codec',
                      style: TextStyle(color: foregroundColor, fontSize: 18),
                    ),

                    Container(
                      decoration: BoxDecoration(
                        color: bgColor2,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: videoCodecList.map((videoCodec) {
                          return CustomRadio(
                            value: videoCodec,
                            selector: (settings) => settings.videoCodec,
                            updater: (settings, val) =>
                                settings.copyWith(videoCodec: val),
                          );
                        }).toList(),
                      ),
                    ),

                    Text(
                      'Audio Codec',
                      style: TextStyle(color: foregroundColor, fontSize: 18),
                    ),

                    Container(
                      decoration: BoxDecoration(
                        color: bgColor2,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: audioCodecList.map((audioCodec) {
                          return CustomRadio(
                            value: audioCodec,
                            selector: (settings) => settings.audioCodec,
                            updater: (settings, val) =>
                                settings.copyWith(audioCodec: val),
                          );
                        }).toList(),
                      ),
                    ),

                    Text(
                      'Output Name',
                      style: TextStyle(color: foregroundColor, fontSize: 18),
                    ),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: bgColor2,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        spacing: 16,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Prefix',
                            style: TextStyle(color: foregroundColor),
                          ),
                          TextField(
                            controller: prefixController,
                            style: TextStyle(color: bgColor),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: inputColor,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onChanged: (value) {
                              settingsNotifier.value = settingsNotifier.value
                                  .copyWith(outputPrefix: value);
                            },
                          ),
                          Text(
                            'Suffix',
                            style: TextStyle(color: foregroundColor),
                          ),
                          TextField(
                            controller: suffixController,
                            style: const TextStyle(color: bgColor),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: inputColor,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onChanged: (value) {
                              settingsNotifier.value = settingsNotifier.value
                                  .copyWith(outputSuffix: value);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: barColor),
            child: Row(
              spacing: 16,
              children: [
                Expanded(
                  child: ValueListenableBuilder<UiSettings>(
                    valueListenable: settingsNotifier,
                    builder: (context, settings, _) {
                      return CodeInput(output: buildComando(settings));
                    },
                  ),
                ),

                CustomBtnPrimary(
                  glyph: const Icon(Icons.swap_horiz),
                  tooltip: 'Convert Files',
                  bg: detailsColor,

                  action: convertFiles,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
