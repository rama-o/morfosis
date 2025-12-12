import 'package:flutter/material.dart';
import 'package:morfosis/models/format_option.dart';
import '../state/notifier.dart';
import '../models/ui_settings.dart';
import '../utils/codec_mappings.dart';
import '../widgets/radio_option.dart';
import '../widgets/checkbox.dart';
import '../widgets/button_secondary.dart';
import '../widgets/section_title.dart';
import '../widgets/textbox.dart';
import '../utils/app_colors.dart';

final suffixController = TextEditingController(
  text: settingsNotifier.value.outputSuffix,
);

final prefixController = TextEditingController(
  text: settingsNotifier.value.outputPrefix,
);

class SettingsView extends StatelessWidget {
  final void Function(int) navigateTo;

  const SettingsView({super.key, required this.navigateTo});

  @override
  Widget build(BuildContext context) {
    final colors = ColorsProvider.of(context);

    return ValueListenableBuilder<UiSettings>(
      valueListenable: settingsNotifier,
      builder: (context, settings, _) {
        return SafeArea(
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
                      accent: colors.primary,

                      action: () => navigateTo(0),
                    ),
                  ],
                ),

                Text(
                  'Output Name',
                  style: TextStyle(color: colors.foreground, fontSize: 18),
                ),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colors.backgroundSecondary,
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
                              .copyWith(outputPrefix: value);
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

                CustomCheckboxOption(
                  option: FormatOption(
                    label: 'Overwrite Files',
                    description: 'Replace existing files with the new ones',
                  ),
                  selector: (s) => s.overwrite,
                  updater: (s, val) => s.copyWith(overwrite: val),
                ),

                Text(
                  'Format',
                  style: TextStyle(color: colors.foreground, fontSize: 18),
                ),

                Container(
                  decoration: BoxDecoration(
                    color: colors.backgroundSecondary,
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
                  style: TextStyle(color: colors.foreground, fontSize: 18),
                ),

                Container(
                  decoration: BoxDecoration(
                    color: colors.backgroundSecondary,
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
                  style: TextStyle(color: colors.foreground, fontSize: 18),
                ),

                Container(
                  decoration: BoxDecoration(
                    color: colors.backgroundSecondary,
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
              ],
            ),
          ),
        );
      },
    );
  }
}
