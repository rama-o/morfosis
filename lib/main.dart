import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(const MorfosisApp());
}

// Color darken(Color color, [double amount = .1]) {
//   assert(amount >= 0 && amount <= 1);

//   final hsl = HSLColor.fromColor(color);
//   final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

//   return hslDark.toColor();
// }

// Color lighten(Color color, [double amount = .1]) {
//   assert(amount >= 0 && amount <= 1);

//   final hsl = HSLColor.fromColor(color);
//   final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

//   return hslLight.toColor();
// }

const Color bgColor = Color.fromARGB(255, 20, 20, 23);
const Color bgColor2 = Color.fromARGB(255, 25, 25, 28);
const Color barColor = Color.fromARGB(255, 20, 25, 29);
const Color accentColor = Color.fromARGB(255, 170, 150, 241);
const Color dangerColor = Color(0xffff8080);
const Color foregroundColor = Color(0xffcccccc);

final Color uncheckedColor = const Color.fromARGB(255, 122, 110, 167);
final Color checkedColor = accentColor;
final Color inputColor = const Color.fromARGB(255, 69, 62, 92);

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

final ValueNotifier<List<File>> filesNotifier = ValueNotifier([]);

void addFile(File file) {
  final updatedFiles = [...filesNotifier.value, file];

  final uniqueFiles = {for (var f in updatedFiles) f.path: f}.values.toList();

  uniqueFiles.sort((a, b) => p.basename(a.path).compareTo(p.basename(b.path)));

  filesNotifier.value = uniqueFiles;
}

void removeFile(File file) {
  filesNotifier.value = filesNotifier.value.where((f) => f != file).toList();
}

void clearQueue() {
  filesNotifier.value = [];
}

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

final suffixController = TextEditingController(
  text: settingsNotifier.value.outputSuffix,
);

final prefixController = TextEditingController(
  text: settingsNotifier.value.outputPrefix,
);

Future<void> pickAudioOrVideo() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowMultiple: true,
    allowedExtensions: formatList,
  );

  if (result != null) {
    for (var platformFile in result.files) {
      if (platformFile.path != null) {
        addFile(File(platformFile.path!));
      }
    }
  } else {
    print("User canceled");
  }
}

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // full width
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor2,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // horizontal centering
        children: [
          const Icon(Icons.inbox, size: 48, color: Colors.grey),
          const SizedBox(height: 8),
          Text(
            "No files yet",
            style: TextStyle(fontSize: 18, color: Colors.grey[400]),
          ),
          const SizedBox(height: 16),
          CustomBtnPrimary(
            glyph: const Icon(Icons.add),
            tooltip: 'Add Files',
            accent: accentColor,
            label: 'Add Files',
            action: () async {
              await pickAudioOrVideo();
            },
          ),
        ],
      ),
    );
  }
}


class SectionTitle extends StatelessWidget {
  final String label;

  const SectionTitle({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(label, style: TextStyle(color: foregroundColor, fontSize: 28));
  }
}

class CustomTextbox extends StatelessWidget {
  final TextEditingController ctrl;
  final ValueChanged<String> onChanged;
  final String label;

  const CustomTextbox({
    super.key,
    required this.ctrl,
    required this.onChanged,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: foregroundColor)),
        TextField(
          controller: ctrl,
          style: const TextStyle(color: foregroundColor),
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
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class CustomBtnBase extends StatelessWidget {
  final Icon glyph;
  final String tooltip;
  final Color accent;
  final VoidCallback action;
  final String? label;
  final bool isPrimary;

  const CustomBtnBase({
    super.key,
    required this.glyph,
    required this.tooltip,
    required this.accent,
    required this.action,
    this.label,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    if (label == null) {
      return Tooltip(
        message: tooltip,
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: action,
          child: Container(
            decoration: BoxDecoration(
              color: isPrimary ? accent : Colors.transparent,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(12),
            child: Icon(
              glyph.icon,
              color: isPrimary ? bgColor : accent, 
              size: glyph.size ?? 18,
            ),
          ),
        ),
      );
    }

    return TextButton.icon(
      style: TextButton.styleFrom(
        backgroundColor: isPrimary ? accent : Colors.transparent,
        foregroundColor: isPrimary ? bgColor : accent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
      onPressed: action,
      icon: glyph,
      label: Text(label!),
    );
  }
}

class CustomBtnSecondary extends CustomBtnBase {
  const CustomBtnSecondary({
    super.key,
    required super.glyph,
    required super.tooltip,
    required super.accent,
    required super.action,
    super.label,
  }) : super(isPrimary: false);
}

class CustomBtnPrimary extends CustomBtnBase {
  const CustomBtnPrimary({
    super.key,
    required super.glyph,
    required super.tooltip,
    required super.accent,
    required super.action,
    super.label,
  }) : super(isPrimary: true);
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
  final File file;

  const ListItem({super.key, required this.id, required this.file});

  @override
  Widget build(BuildContext context) {
    final String name = p.basenameWithoutExtension(file.path);
    final String inputFormat = p.extension(file.path).replaceFirst('.', '');

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
          Row(
            spacing: 16,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(color: foregroundColor, fontSize: 18),
                    ),
                    Text(
                      '$inputFormat → ${settingsNotifier.value.outputFormat}',
                      style: TextStyle(color: foregroundColor),
                    ),
                  ],
                ),
              ),
              CustomBtnSecondary(
                glyph: const Icon(Icons.delete),
                tooltip: 'Delete Item',
                accent: dangerColor,
                action: () {
                  removeFile(file);
                },
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

  void convertFiles() {}
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
                          accent: accentColor,
                          action: () async {
                            await pickAudioOrVideo();
                          },
                        ),
                        CustomBtnSecondary(
                          glyph: const Icon(Icons.cleaning_services),
                          tooltip: 'Clear Queue',
                          accent: accentColor,
                          action: clearQueue,
                        ),
                        CustomBtnSecondary(
                          glyph: const Icon(Icons.settings),
                          tooltip: 'Settings',
                          accent: accentColor,
                          action: () => navigateTo(1),
                        ),
                      ],
                    ),

                    if (!errors.isEmpty) PromptOutput(output: errors),

                    ValueListenableBuilder<List<File>>(
                      valueListenable: filesNotifier,
                      builder: (context, files, _) {
                        if (files.isEmpty) {
                          return const EmptyList();
                        }

                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: files.length,
                          itemBuilder: (context, index) {
                            final file = files[index];
                            return ListItem(file: file, id: index);
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 16),
                        );
                      },
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
                          glyph: const Icon(Icons.close),
                          tooltip: 'Close Settings',
                          accent: accentColor,

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
                          CustomTextbox(
                            label: 'Prefix',
                            ctrl: prefixController,
                            onChanged: (value) {
                              settingsNotifier.value = settingsNotifier.value
                                  .copyWith(outputSuffix: value);
                            },
                          ),
                          CustomTextbox(
                            label: 'Suffix',
                            ctrl: suffixController,
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
                  accent: accentColor,

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
