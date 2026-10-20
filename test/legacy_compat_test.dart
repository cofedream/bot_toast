// Verifies that bot_toast (built against package:material_ui) still works in an
// app that has not yet migrated and still uses package:flutter/material.dart.
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart' as legacy;
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('works inside a legacy MaterialApp', (WidgetTester tester) async {
    await tester.pumpWidget(legacy.MaterialApp(
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      home: legacy.Builder(
        builder: (legacy.BuildContext context) => legacy.TextButton(
          key: const legacy.ValueKey('main'),
          onPressed: () {
            BotToast.showText(text: 'legacyText');
          },
          child: const legacy.Text(''),
        ),
      ),
    ));

    await tester.tap(find.byKey(const legacy.ValueKey('main')));
    await tester.pump();
    await tester.pump();
    await tester.pump();

    expect(find.text('legacyText'), findsOneWidget);
  });

  testWidgets('enhanced widget works inside a legacy MaterialApp',
      (WidgetTester tester) async {
    await tester.pumpWidget(legacy.MaterialApp(
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      home: legacy.Builder(
        builder: (legacy.BuildContext context) => legacy.TextButton(
          key: const legacy.ValueKey('main'),
          onPressed: () {
            BotToast.showEnhancedWidget(
              duration: const Duration(seconds: 999),
              toastBuilder: (_) => const legacy.Text('enhancedText'),
            );
          },
          child: const legacy.Text(''),
        ),
      ),
    ));

    await tester.tap(find.byKey(const legacy.ValueKey('main')));
    await tester.pump();
    await tester.pump();
    await tester.pump();

    expect(find.text('enhancedText'), findsOneWidget);
  });
}
