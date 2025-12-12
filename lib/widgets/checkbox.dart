import 'package:flutter/material.dart';
import '../state/notifier.dart';
import '../models/ui_settings.dart';
import '../models/format_option.dart';
import '../utils/app_colors.dart';

class CustomCheckboxOption extends StatelessWidget {
  final FormatOption option;
  final bool Function(UiSettings) selector;
  final UiSettings Function(UiSettings, bool) updater;

  const CustomCheckboxOption({
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
        final checked = selector(settings);
        return CheckboxListTile(
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
          value: checked,
          onChanged: (val) {
            if (val != null) {
              settingsNotifier.value = updater(settings, val);
            }
          },
          activeColor: colors.input,
          checkColor: colors.foreground,
          tileColor: Colors.transparent,
          controlAffinity: ListTileControlAffinity.leading,
        );
      },
    );
  }
}
