import 'package:flutter/material.dart';
import '../theme.dart';
import '../state/notifier.dart';
import '../models/ui_settings.dart';
import '../widgets/button_secondary.dart';
import '../widgets/section_title.dart';

class Badge extends StatelessWidget {
  final String label;
  final IconData? icon; // optional
  final double iconSize;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final EdgeInsets padding;
  final double borderRadius;

  const Badge({
    super.key,
    required this.label,
    this.icon,
    this.iconSize = 22,
    this.textStyle,
    this.backgroundColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    final Color bg = backgroundColor ?? accentColor;
    final TextStyle style =
        textStyle ??
        const TextStyle(
          fontSize: 14,
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
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: iconSize, color: style.color),
            const SizedBox(width: 4),
          ],
          Text(label, style: style),
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

                Image.asset('img/morfosis_brand.png', width: 100),
                Text(
                  'Morfosis is a privacy-first media conversion app designed to be simple and accessible.\n\n'
                  'It works completely on-device, requires no internet connection, and contains no trackers.\n\n'
                  'Powered by FFmpeg, Morfosis allows you to convert audio and video files between a wide range of formats.',
                  style: TextStyle(fontSize: 16, color: foregroundColor),
                  textAlign: TextAlign.center,
                ),
                Row(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Badge(label: 'License: GPLv3', icon: Icons.shield),
                    Badge(label: 'Creator: Miguel Rivas', icon: Icons.person),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
