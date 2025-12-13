import 'package:flutter/material.dart';
import '../state/notifier.dart';
import '../models/ui_settings.dart';
import '../widgets/button_secondary.dart';
import '../widgets/section_title.dart';
import '../widgets/badge.dart';
import '../widgets/link.dart';
import '../utils/app_colors.dart';

class AboutView extends StatelessWidget {
  final void Function(int) navigateTo;

  const AboutView({super.key, required this.navigateTo});

  @override
  Widget build(BuildContext context) {
    final colors = ColorsProvider.of(context);

    return ValueListenableBuilder<UiSettings>(
      valueListenable: settingsNotifier,
      builder: (context, settings, _) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              spacing: 48,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  spacing: 8,
                  children: [
                    Expanded(child: SectionTitle(label: 'About')),
                    CustomBtnSecondary(
                      glyph: const Icon(Icons.close),
                      tooltip: 'Close About',
                      accent: colors.primary,

                      action: () => navigateTo(0),
                    ),
                  ],
                ),

                Column(
                  spacing: 16,
                  children: [
                    Image.asset('img/morfosis_brand.png', height: 120),
                    Column(
                      children: [
                        Text(
                          "Morfosis",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Powered by FFmpeg, Morfosis lets you convert audio and video files between many formats, all processed locally on your device without any internet connection.",
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),

                    Column(
                      spacing: 8,
                      children: [
                        CustomBadge(label: 'No Ads', icon: Icons.ads_click),
                        CustomBadge(
                          label: 'No Background Tasks',
                          icon: Icons.block,
                        ),
                        CustomBadge(
                          label: 'No Trackers',
                          icon: Icons.location_on,
                        ),
                        CustomBadge(label: 'Works Offline', icon: Icons.wifi),
                        CustomBadge(
                          label: 'License: GPLv3',
                          icon: Icons.shield,
                        ),
                      ],
                    ),

                    CustomLink(
                      url: 'https://github.com/jmiguelrivas/morfosis',
                      label: 'github.com/jmiguelrivas/morfosis',
                      icon: Icons.monitor,
                    ),
                    CustomLink(
                      url: 'https://github.com/jmiguelrivas',
                      label: 'Author: Miguel Rivas',
                      icon: Icons.person,
                    ),
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
