import 'dart:io';
import 'package:flutter/material.dart';
import '../models/ui_settings.dart';

final ValueNotifier<UiSettings> settingsNotifier = ValueNotifier(UiSettings());
final ValueNotifier<List<File>> filesNotifier = ValueNotifier([]);
