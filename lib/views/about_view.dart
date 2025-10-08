import 'package:flutter/material.dart';
import '../theme.dart';
import '../state/notifier.dart';
import '../models/ui_settings.dart';
import '../widgets/button_secondary.dart';
import '../widgets/section_title.dart';
import '../widgets/badge.dart';
import '../widgets/link.dart';

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

                Image.asset('img/morfosis_brand.png'),
                
                Column(
                  spacing: 8,
                  // runSpacing: 8,
                  // alignment: WrapAlignment.center,
                  children: [
                    CustomBadge(label: 'Ads: No', icon: Icons.ads_click),
                    CustomBadge(label: 'Runs in Background: No', icon: Icons.block),
                    CustomBadge(label: 'Trackers: No', icon: Icons.location_on),
                    CustomBadge(label: 'Works Offline: Yes', icon: Icons.wifi),
                    CustomBadge(label: 'License: GPLv3', icon: Icons.shield),
                    CustomLink(
                      url: 'https://rama-o.github.io',
                      label: 'Website: rama-o.github.io',
                      icon: Icons.monitor,
                    ),
                    CustomLink(
                      url: 'https://jmiguelrivas.github.io',
                      label: 'Creator: Miguel Rivas',
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
