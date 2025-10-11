import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:morfosis/app/morfosis_app.dart';

void main() {
  testWidgets('Navigation test', (WidgetTester tester) async {
    // Build app
    await tester.pumpWidget(const MorfosisApp());
    await tester.pumpAndSettle();

    expect(find.text('No files yet'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.settings));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();

    expect(find.text('Output Name'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();

    expect(find.text('No files yet'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.settings));
    await tester.pumpAndSettle();
    await tester.tap(find.text('About'));
    await tester.pumpAndSettle();

    expect(find.text('Ads: No'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();

    expect(find.text('No files yet'), findsOneWidget);
  });
}
