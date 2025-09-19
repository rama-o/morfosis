import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

void main() {
  runApp(const MorfosisApp());
}

const Color bgColor = Color(0xff364245);
const Color bgColor2 = Color(0xff364852);
const Color actionColor = Color(0xff467f68);
const Color dangerColor = Color(0xffff8080);
const Color foregroundColor = Color(0xffcccccc);
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
    this.outputSuffix = '',
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

final String comando = 'ffmpeg -i * -o *';

const formatList = [
  'Keep Original',
  'mp4',
  'avi',
  'webm',
  'wmv',
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

const queue = ['/home/alejandro video.wmv', '/home/juana camacho.avi'];

class SectionTitle extends StatelessWidget {
  final String label;

  const SectionTitle({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(label, style: TextStyle(color: foregroundColor, fontSize: 28));
  }
}

class CustomBtn extends StatelessWidget {
  final Icon glyph;
  final String tooltip;
  final Color bg;
  final Color fg;
  final VoidCallback action;

  const CustomBtn({
    super.key,
    required this.glyph,
    required this.tooltip,
    required this.bg,
    required this.fg,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        icon: glyph,
        tooltip: tooltip,
        color: fg,
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

// class CustomCheckbox extends StatelessWidget {
//   final String label;
//   final bool Function(UiSettings) selector;
//   final UiSettings Function(UiSettings, bool) updater;

//   const CustomCheckbox({
//     super.key,
//     required this.label,
//     required this.selector,
//     required this.updater,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<UiSettings>(
//       valueListenable: settingsNotifier,
//       builder: (context, settings, _) {
//         final checked = selector(settings);
//         return CheckboxListTile(
//           title: Text(label, style: TextStyle(color: foregroundColor)),
//           value: checked,
//           onChanged: (val) {
//             if (val != null) {
//               settingsNotifier.value = updater(settings, val);
//             }
//           },
//           fillColor: MaterialStateProperty.resolveWith<Color>((states) {
//             if (states.contains(MaterialState.selected)) return checkedColor;
//             return uncheckedColor;
//           }),
//           activeColor: checkedColor,
//         );
//       },
//     );
//   }
// }

class CodeInput extends StatelessWidget {
  final String output;

  const CodeInput({super.key, required this.output});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xff242b2f),
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
    final String inputFormat = p.extension(path).replaceFirst('.', '');

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
          Text(name, style: TextStyle(color: foregroundColor, fontSize: 22)),
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xff4b7076),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '100%',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: foregroundColor),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 12, 141, 141),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  inputFormat,
                  style: TextStyle(color: foregroundColor),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xff1279b1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  settingsNotifier.value.outputFormat,
                  style: TextStyle(color: foregroundColor),
                ),
              ),
              CustomBtn(
                glyph: const Icon(Icons.delete),
                tooltip: 'Delete Item',
                bg: dangerColor,
                fg: foregroundColor,
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
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    spacing: 8,
                    children: [
                      Expanded(child: SectionTitle(label: 'Queue')),
                      CustomBtn(
                        glyph: const Icon(Icons.add),
                        tooltip: 'Add Files',
                        bg: actionColor,
                        fg: foregroundColor,
                        action: addFiles,
                      ),
                      CustomBtn(
                        glyph: const Icon(Icons.cleaning_services),
                        tooltip: 'Clear Queue',
                        bg: dangerColor,
                        fg: foregroundColor,
                        action: clearQueue,
                      ),
                      CustomBtn(
                        glyph: const Icon(Icons.settings),
                        tooltip: 'Settings',
                        bg: actionColor,
                        fg: foregroundColor,
                        action: () => navigateTo(1),
                      ),
                    ],
                  ),

                  CodeInput(output: comando),

                  if (!errors.isEmpty) PromptOutput(output: errors),

                  Column(
                    spacing: 16,
                    children: queue
                        .map(
                          (item) => ListItem(
                            path: item,
                            id: queue.indexOf(item), // not ideal if duplicates
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),

            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    spacing: 8,
                    children: [
                      Expanded(child: SectionTitle(label: 'Settings')),
                      CustomBtn(
                        glyph: const Icon(Icons.autorenew),
                        tooltip: 'Reset Settings',
                        bg: dangerColor,
                        fg: foregroundColor,
                        action: clearQueue,
                      ),
                      CustomBtn(
                        glyph: const Icon(Icons.close),
                        tooltip: 'Close Settings',
                        bg: actionColor,
                        fg: foregroundColor,
                        action: () => navigateTo(0),
                      ),
                    ],
                  ),

                  CodeInput(output: comando),
                  if (!errors.isEmpty) PromptOutput(output: errors),

                  Text(
                    'Format',
                    style: TextStyle(color: foregroundColor, fontSize: 22),
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
                    style: TextStyle(color: foregroundColor, fontSize: 22),
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
                    style: TextStyle(color: foregroundColor, fontSize: 22),
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
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16),
          child: CustomBtn(
            glyph: const Icon(Icons.swap_horiz),
            tooltip: 'Convert Files',
            bg: Color.fromARGB(255, 150, 56, 187),
            fg: foregroundColor,
            action: convertFiles,
          ),
        ),
      ),
    );
  }
}
