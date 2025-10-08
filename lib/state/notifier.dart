import 'package:flutter/material.dart';
import '../models/ui_settings.dart';
import '../models/file_item.dart';
import 'package:flutter/foundation.dart';

final ValueNotifier<UiSettings> settingsNotifier = ValueNotifier(UiSettings());
final ValueNotifier<List<String>> errorsNotifier = ValueNotifier([]);

// final ValueNotifier<List<FileItem>> filesNotifier = ValueNotifier([]);
final filesNotifier = ValueNotifier<List<FileItem>>([]);

final ValueNotifier<bool> isLoadingFiles = ValueNotifier(false);