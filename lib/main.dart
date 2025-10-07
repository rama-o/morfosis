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

  runApp(MorfosisApp());
}

Future<void> requestNotificationPermission() async {
  final status = await Permission.notification.status;

  if (!status.isGranted) {
    // Ask the user for permission
    await Permission.notification.request();
  }
}
