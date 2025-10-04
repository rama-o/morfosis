import 'package:flutter/material.dart';
import '../theme.dart';
import '../state/notifier.dart';
import '../models/ui_settings.dart';
import '../models/format_option.dart';

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
    return ValueListenableBuilder<UiSettings>(
      valueListenable: settingsNotifier,
      builder: (context, settings, _) {
        final checked = selector(settings);
        return CheckboxListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(option.label, style: TextStyle(color: foregroundColor)),
              Text(
                option.description,
                style: TextStyle(fontSize: 12, color: Colors.grey[400]),
              ),
            ],
          ),
          value: checked,
          onChanged: (val) {
            if (val != null) {
              settingsNotifier.value = updater(settings, val);
            }
          },
          activeColor: checkedColor,
          checkColor: Colors.white,
          tileColor: Colors.transparent,
          controlAffinity: ListTileControlAffinity.leading,
        );
      },
    );
  }
}
