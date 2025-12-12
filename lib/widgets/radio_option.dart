import 'package:flutter/material.dart';
import '../state/notifier.dart';
import '../models/ui_settings.dart';
import '../models/format_option.dart';
import '../utils/app_colors.dart';

class CustomRadioOption extends StatelessWidget {
  final FormatOption option;
  final String Function(UiSettings) selector;
  final UiSettings Function(UiSettings, String) updater;

  const CustomRadioOption({
    super.key,
    required this.option,
    required this.selector,
    required this.updater,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ColorsProvider.of(context);

    return ValueListenableBuilder<UiSettings>(
      valueListenable: settingsNotifier,
      builder: (context, settings, _) {
        final groupValue = selector(settings);
        return RadioListTile<String>(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(option.label, style: TextStyle(color: colors.foreground)),
              Text(
                option.description,
                style: TextStyle(fontSize: 12, color: colors.foreground),
              ),
            ],
          ),
          value: option.label,
          groupValue: groupValue,
          onChanged: (val) {
            if (val != null) {
              settingsNotifier.value = updater(settings, val);
            }
          },
          fillColor: WidgetStateProperty.resolveWith<Color>((states) {
            return colors.primary;
          }),
        );
      },
    );
  }
}
