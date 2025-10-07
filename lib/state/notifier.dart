import 'package:flutter/material.dart';
import '../models/ui_settings.dart';
import '../models/file_item.dart';

final ValueNotifier<UiSettings> settingsNotifier = ValueNotifier(UiSettings());
final ValueNotifier<List<FileItem>> filesNotifier = ValueNotifier([]);
final ValueNotifier<List<String>> errorsNotifier = ValueNotifier([]);