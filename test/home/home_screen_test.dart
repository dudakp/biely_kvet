import 'package:flutter_test/flutter_test.dart';
import 'package:biely_kvet/main.dart';

void main() {
  testWidgets('Navigácia na AnswerScreen funguje', (tester) async {
    await tester.pumpWidget(const BielyKvetApp());

    await tester.tap(find.text('Hľadať odpoveď'));
    await tester.pumpAndSettle();

    expect(find.text('Hľadaj odpoveď'), findsOneWidget);
    expect(find.text('Daj číslo otázky, bazerant'), findsOneWidget);
    expect(find.text('Ukáž'), findsOneWidget);
  });

  testWidgets('Navigácia na TimerScreen funguje', (tester) async {
    await tester.pumpWidget(const BielyKvetApp());

    await tester.tap(find.text('Časovač'));
    await tester.pumpAndSettle();

    expect(find.text('Časovač'), findsOneWidget);
    expect(find.text('Čas v sekundách'), findsOneWidget);
  });

  testWidgets('Navigácia na RulesScreen funguje', (tester) async {
    await tester.pumpWidget(const BielyKvetApp());

    await tester.tap(find.text('Pravidlá hry'));
    await tester.pumpAndSettle();

    expect(find.text('Pravidlá hry'), findsOneWidget);
    expect(find.text('Pravidlá hry Biely kvet'), findsOneWidget);
  });
}
