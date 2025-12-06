import 'package:flutter_test/flutter_test.dart';
import 'package:biely_kvet/main.dart';

void main() {
  testWidgets('RulesScreen – základné texty', (tester) async {
    await tester.pumpWidget(const BielyKvetApp());

    await tester.tap(find.text('Pravidlá'));
    await tester.pumpAndSettle();

    expect(find.text('Pravidlá hry Biely kvet'), findsOneWidget);
    expect(find.text('PRIEBEH HRY'), findsOneWidget);
  });
}
