import 'package:flutter/material.dart';
import '../theme.dart';

import '../widgets/button_primary.dart';
import '../state/notifier.dart';
import '../widgets/code_input.dart';
import '../models/ui_settings.dart';
import '../utils/command_builder.dart';

import '../views/queue_view.dart';
import '../views/settings_view.dart';
import '../views/about_view.dart';
import '../models/file_item.dart';
import '../utils/file_utils.dart';

import '../utils/notifications.dart';

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        iconTheme: const IconThemeData(color: foregroundColor),
        textTheme: ThemeData.dark().textTheme.apply(bodyColor: foregroundColor),
      ),
      themeMode: ThemeMode.dark,
      home: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => currentViewIndex = index);
          },
          children: [
            QueueView(navigateTo: navigateTo),
            SettingsView(navigateTo: navigateTo),
            AboutView(navigateTo: navigateTo),
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

                ValueListenableBuilder<List<FileItem>>(
                  valueListenable: filesNotifier,
                  builder: (context, file, _) {
                    if (filesNotifier.value.isEmpty) {
                      return CustomBtnPrimary(
                        glyph: const Icon(Icons.swap_horiz),
                        tooltip: 'Convert Files',
                        accent: disabledColor,
                        action: () {},
                      );
                    }

                    return CustomBtnPrimary(
                      glyph: const Icon(Icons.swap_horiz),
                      tooltip: 'Convert Files',
                      accent: accentColor,

                      action: convertFiles,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
