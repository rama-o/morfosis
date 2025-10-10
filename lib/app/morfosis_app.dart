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
import 'package:permission_handler/permission_handler.dart';

class MorfosisApp extends StatefulWidget {
  const MorfosisApp({super.key});

  @override
  State<MorfosisApp> createState() => _MorfosisAppState();
}

class _MorfosisAppState extends State<MorfosisApp> {
  final PageController _pageController = PageController();
  int currentViewIndex = 0;

  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  void navigateTo(int index) {
    setState(() => currentViewIndex = index);
    _pageController.jumpToPage(index);
  }

  Future<void> _initializeApp() async {
    try {
      // Initialize notifications
      await initializeNotifications();

      // Request permissions safely
      await _requestNotificationPermission();
      // await _requestStoragePermission();
    } catch (e) {
      print('Initialization error: $e');
    } finally {
      setState(() => _initialized = true);
    }
  }

  Future<void> _requestNotificationPermission() async {
    try {
      final status = await Permission.notification.status;
      if (!status.isGranted) {
        await Permission.notification.request();
      }
    } catch (e) {
      print('Notification permission error: $e');
    }
  }

  // Future<void> _requestStoragePermission() async {
  //   try {
  //     if (!await Permission.manageExternalStorage.isGranted) {
  //       var status = await Permission.manageExternalStorage.request();
  //       if (!status.isGranted) {
  //         await openAppSettings();
  //       }
  //     }
  //   } catch (e) {
  //     print('Storage permission error: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      // Show loading while initializing
      return MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }

    // Main app after initialization
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
                      return FutureBuilder<String>(
                        future: buildComando(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return CodeInput(
                              output: snapshot.data!,
                            );
                          }
                        },
                      );
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
