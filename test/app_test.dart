import 'package:flutter_test/flutter_test.dart';
import 'package:biely_kvet/main.dart';

void main() {
  testWidgets('App načíta hlavné menu', (tester) async {
    await tester.pumpWidget(const BielyKvetApp());

    expect(find.text('Biely kvet'), findsOneWidget);
    expect(find.text('Hľadať odpoveď'), findsOneWidget);
    expect(find.text('Časovač'), findsOneWidget);
    expect(find.text('Pravidlá hry'), findsOneWidget);
  });
}
