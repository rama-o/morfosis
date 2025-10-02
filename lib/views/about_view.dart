import 'package:flutter/material.dart';
import '../theme.dart';
import '../state/notifier.dart';
import '../models/ui_settings.dart';
import '../widgets/button_secondary.dart';
import '../widgets/section_title.dart';

class GPLv3Badge extends StatelessWidget {
  final double iconSize;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final EdgeInsets padding;
  final double borderRadius;

  const GPLv3Badge({
    super.key,
    this.iconSize = 22,
    this.textStyle,
    this.backgroundColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    final Color bg = backgroundColor ?? accentColor2;
    final TextStyle style =
        textStyle ??
        const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        );

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        spacing: 4,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.shield, size: iconSize, color: style.color),
          Text('GPLv3', style: style),
        ],
      ),
    );
  }
}

class AboutView extends StatelessWidget {
  final void Function(int) navigateTo;

  const AboutView({super.key, required this.navigateTo});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<UiSettings>(
      valueListenable: settingsNotifier,
      builder: (context, settings, _) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  spacing: 8,
                  children: [
                    Expanded(child: SectionTitle(label: 'About')),
                    CustomBtnSecondary(
                      glyph: const Icon(Icons.close),
                      tooltip: 'Close About',
                      accent: accentColor,

                      action: () => navigateTo(0),
                    ),
                  ],
                ),

                Image.asset('img/morfosis.png', width: 150),
                Text(
                  'Morfosis is a privacy-first media conversion app designed to be simple and accessible.\n\n'
                  'It works completely on-device, requires no internet connection, and contains no trackers.\n\n'
                  'Powered by FFmpeg, Morfosis allows you to convert audio and video files between a wide range of formats.',
                  style: TextStyle(fontSize: 16, color: foregroundColor),
                  textAlign: TextAlign.center,
                ),
                GPLv3Badge(),
              ],
            ),
          ),
        );
      },
    );
  }
}
