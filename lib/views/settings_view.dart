import 'package:flutter/material.dart';
import '../theme.dart';
import '../state/settings_notifier.dart';
import '../models/ui_settings.dart';
import '../utils/codec_mappings.dart';
import '../widgets/radio_option.dart';
import '../widgets/button_secondary.dart';
import '../widgets/section_title.dart';
import '../widgets/prompt_output.dart';
import '../widgets/textbox.dart';

final suffixController = TextEditingController(
  text: settingsNotifier.value.outputSuffix,
);

final prefixController = TextEditingController(
  text: settingsNotifier.value.outputPrefix,
);

class SettingsView extends StatelessWidget {
  final List<String> errors;
  final void Function(int) navigateTo;

  const SettingsView({
    super.key,
    required this.errors,
    required this.navigateTo,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<UiSettings>(
      valueListenable: settingsNotifier,
      builder: (context, settings, _) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
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
                  child: ValueListenableBuilder<UiSettings>(
                    valueListenable: settingsNotifier,
                    builder: (context, settings, _) {
                      final availableFormats = [
                        ...audioFormats,
                        ...videoFormats,
                      ];

                      return Column(
                        children: availableFormats.map((formats) {
                          return CustomRadioOption(
                            option: formats,
                            selector: (s) => s.outputFormat,
                            updater: (s, val) => s.copyWith(outputFormat: val),
                          );
                        }).toList(),
                      );
                    },
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
                  child: ValueListenableBuilder<UiSettings>(
                    valueListenable: settingsNotifier,
                    builder: (context, settings, _) {
                      final selectedFormat = settings.outputFormat;
                      final availableCodecs = getVideoCodecsForFormat(
                        selectedFormat,
                      );

                      return Column(
                        children: availableCodecs.map((codecOption) {
                          return CustomRadioOption(
                            option: codecOption,
                            selector: (s) => s.videoCodec,
                            updater: (s, val) => s.copyWith(videoCodec: val),
                          );
                        }).toList(),
                      );
                    },
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
                  child: ValueListenableBuilder<UiSettings>(
                    valueListenable: settingsNotifier,
                    builder: (context, settings, _) {
                      final selectedFormat = settings.outputFormat;
                      final availableCodecs = getAudioCodecsForFormat(
                        selectedFormat,
                      );

                      return Column(
                        children: availableCodecs.map((codecOption) {
                          return CustomRadioOption(
                            option: codecOption,
                            selector: (s) => s.audioCodec,
                            updater: (s, val) => s.copyWith(audioCodec: val),
                          );
                        }).toList(),
                      );
                    },
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
        );
      },
    );
  }
}
