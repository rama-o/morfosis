import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/app_colors.dart';

class CustomLink extends StatelessWidget {
  final String url;
  final String label;
  final IconData? icon;

  const CustomLink({
    super.key,
    required this.url,
    required this.label,
    required this.icon,
  });

  Future<void> _launchURL() async {
    final Uri uri = Uri.parse(url.startsWith('http') ? url : 'https://$url');
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = ColorsProvider.of(context);

    return SizedBox(
      width: double.infinity,
      child: TextButton.icon(
        onPressed: _launchURL,
        style: TextButton.styleFrom(
          backgroundColor: colors.secondary,
          foregroundColor: colors.background,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        icon: Icon(icon, size: 22, color: colors.background),
        label: Text(label),
      ),
    );
  }
}
