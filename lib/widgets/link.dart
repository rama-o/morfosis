import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import './badge.dart';
import '../theme.dart';

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
    return GestureDetector(
      onTap: _launchURL,
      child: CustomBadge(
        label: label,
        icon: icon,
        backgroundColor: accentColor2,
      ),
    );
  }
}
