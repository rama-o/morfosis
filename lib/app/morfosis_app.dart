import 'package:flutter/material.dart';

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

import 'dart:io' show Platform;
import '../utils/notifications.dart';
import 'package:permission_handler/permission_handler.dart';

import '../utils/app_colors.dart';
import 'package:dynamic_color/dynamic_color.dart';

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
    if (Platform.environment.containsKey('FLUTTER_TEST')) return;

    try {
      final status = await Permission.notification.status;
      if (!status.isGranted) {
        await Permission.notification.request();
      }
    } catch (e) {
      print('Notification permission error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }

    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        final scheme =
            darkDynamic ?? ColorScheme.fromSeed(seedColor: Colors.pink);
        final appColors = AppColors.fromScheme(scheme);

        return ColorsProvider(
          colors: appColors,
          child: MaterialApp(
            darkTheme: ThemeData.dark().copyWith(
              scaffoldBackgroundColor: appColors.background,
              iconTheme: IconThemeData(color: appColors.foreground),
              textTheme: ThemeData.dark().textTheme.apply(
                bodyColor: appColors.foreground,
              ),
            ),
            themeMode: ThemeMode.dark,
            home: Scaffold(
              body: PageView(
                controller: _pageController,
                onPageChanged: (index) =>
                    setState(() => currentViewIndex = index),
                children: [
                  QueueView(navigateTo: navigateTo),
                  SettingsView(navigateTo: navigateTo),
                  AboutView(navigateTo: navigateTo),
                ],
              ),
              bottomNavigationBar: SafeArea(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: appColors.bar),
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
                                  return CodeInput(output: snapshot.data!);
                                }
                              },
                            );
                          },
                        ),
                      ),
                      ValueListenableBuilder<List<FileItem>>(
                        valueListenable: filesNotifier,
                        builder: (context, file, _) {
                          final colors = ColorsProvider.of(context);
                          if (filesNotifier.value.isEmpty) {
                            return CustomBtnPrimary(
                              glyph: const Icon(Icons.swap_horiz),
                              tooltip: 'Convert Files',
                              accent: colors.disabled,
                              action: () {},
                            );
                          }

                          return CustomBtnPrimary(
                            glyph: const Icon(Icons.swap_horiz),
                            tooltip: 'Convert Files',
                            accent: colors.primary,
                            action: convertFiles,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
