import 'package:biely_kvet/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Navigácia na AnswerScreen funguje', (tester) async {
    await tester.pumpWidget(const BielyKvetApp());

    await tester.tap(find.text('Odpovede'));
    await tester.pumpAndSettle();

    expect(find.text('Daj číslo otázky, bazerant'), findsOneWidget);
    expect(find.text('Ukáž'), findsOneWidget);
  });

  testWidgets('Navigácia na RulesScreen funguje', (tester) async {
    await tester.pumpWidget(const BielyKvetApp());

    await tester.tap(find.text('Pravidlá'));
    await tester.pumpAndSettle();

    expect(find.text('Pravidlá'), findsOneWidget);
    expect(find.text('Pravidlá hry Biely kvet'), findsOneWidget);
  });
}
