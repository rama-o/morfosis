# Flutter
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class com.yourcompany.** { *; }

# FFmpegKit
-keep class com.antonkarpenko.** { *; }
-keepclassmembers class com.antonkarpenko.** { *; }

# FilePicker
-keep class com.mr.flutter.plugin.filepicker.** { *; }

# Local Notifications
-keep class com.dexterous.flutterlocalnotifications.** { *; }

# Prevent stripping of annotated methods
-keepattributes *Annotation*
