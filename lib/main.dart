import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'app/morfosis_app.dart';
import './utils/notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize notifications
  await initializeNotifications();

  // Request notification permission (Android 13+)
  await requestNotificationPermission();
  await requestStoragePermission();

  runApp(MorfosisApp());
}

Future<void> requestNotificationPermission() async {
  final status = await Permission.notification.status;

  if (!status.isGranted) {
    await Permission.notification.request();
  }
}

Future<void> requestStoragePermission() async {
  if (await Permission.manageExternalStorage.isGranted) {
    return;
  }

  var status = await Permission.manageExternalStorage.request();

  if (!status.isGranted) {
    await openAppSettings();
  }
}