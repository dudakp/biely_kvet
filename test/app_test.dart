import 'package:flutter_test/flutter_test.dart';
import 'package:biely_kvet/main.dart';

void main() {
  testWidgets('App načíta hlavné menu', (tester) async {
    await tester.pumpWidget(const BielyKvetApp());

    expect(find.text('Odpovede'), findsOneWidget);
    expect(find.text('Pravidlá'), findsOneWidget);
  });
}
