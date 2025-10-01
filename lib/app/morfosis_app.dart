import 'package:flutter/material.dart';
import 'package:morfosis/utils/errors_utils.dart';
import 'package:path/path.dart' as p;
import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';

import '../theme.dart';
import '../views/queue_view.dart';
import '../views/settings_view.dart';
import '../widgets/button_primary.dart';
import '../state/notifier.dart';
import '../widgets/code_input.dart';
import '../models/ui_settings.dart';
import '../utils/command_builder.dart';

class MorfosisApp extends StatefulWidget {
  const MorfosisApp({super.key});

  @override
  State<MorfosisApp> createState() => _MorfosisAppState();
}

class _MorfosisAppState extends State<MorfosisApp> {
  final PageController _pageController = PageController();
  int currentViewIndex = 0;

  void navigateTo(int index) {
    setState(() => currentViewIndex = index);
    _pageController.jumpToPage(index);
  }

  Future<void> convertFiles() async {
    clearErrors();

    for (final file in filesNotifier.value) {
      final input = file.path;
      final name = p.basenameWithoutExtension(input);
      // final dir = p.dirname(input);

      final output = p.join(
        'storage',
        'emulated',
        '0',
        'Documents',
        '${settingsNotifier.value.outputPrefix}$name${settingsNotifier.value.outputSuffix}.${settingsNotifier.value.outputFormat}',
      );

      final videoCodecOption =
          settingsNotifier.value.videoCodec != 'Keep Original'
          ? ['-c:v', settingsNotifier.value.videoCodec]
          : [];
      final audioCodecOption =
          settingsNotifier.value.audioCodec != 'Keep Original'
          ? ['-c:a', settingsNotifier.value.audioCodec]
          : [];

      final commandList = [
        '-i "${input}"',
        ...videoCodecOption,
        ...audioCodecOption,
        '"${output}"',
      ];

      final command = commandList.join(' ');

      print('-------------------- Running command: $command');

      await FFmpegKit.executeAsync(
        command,
        (session) async {
          final returnCode = await session.getReturnCode();
          if (ReturnCode.isSuccess(returnCode)) {
            print('✅ Conversion finished: $output');
          } else {
            addError('Conversion failed for $input, rc = $returnCode');
          }
        },
        (log) {
          // Optional: log FFmpeg messages in real-time
          print(log.getMessage());
        },
        (statistics) {
          // Optional: show progress info
          // print(
          //     'Progress: frame=${statistics.getFrame()}, time=${statistics.getTime()}ms');
        },
      );
    }
  }

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
            QueueView(navigateTo: navigateTo),
            SettingsView(navigateTo: navigateTo),
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
                      return CodeInput(output: buildComando());
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
