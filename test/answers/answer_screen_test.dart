import 'package:biely_kvet/domain/home/answers/answer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget wrapScreen(Widget child) {
    return MaterialApp(home: Scaffold(body: child));
  }

  testWidgets('AnswerScreen – prázdny vstup zobrazí upozornenie', (
    tester,
  ) async {
    await tester.pumpWidget(wrapScreen(AnswerScreen()));

    final fieldFinder = find.byType(TextField);
    expect(fieldFinder, findsOneWidget);

    await tester.tap(find.text('Ukáž'));
    await tester.pumpAndSettle();

    expect(
      find.text('Daj číslo otázky, bazerant.'),
      findsOneWidget,
      reason: 'Pri prázdnom vstupe sa má zobraziť upozornenie.',
    );
  });

  testWidgets(
    'AnswerScreen – po zadaní otázky s korektným číslom sa zobrazí dialóg s odpoveďou',
    (tester) async {
      await tester.pumpWidget(wrapScreen(AnswerScreen()));

      // zadam cislo otazky a zobrazim odpoved
      await tester.enterText(find.byType(TextField), '1');
      await tester.tap(find.text('Ukáž'));
      await tester.pumpAndSettle();
      expect(
        find.textContaining('Otázka č. '),
        findsOneWidget,
        reason: 'Po zadaní správneho čísla sa má zobraziť dialóg.',
      );
      expect(find.text('Zatvoriť'), findsOneWidget);

      // zatvorim dialog s odpovedou
      await tester.tap(find.text('Zatvoriť'));
      await tester.pumpAndSettle();
      expect(
        find.text('Zatvoriť'),
        findsNothing,
        reason: 'Po kliknutí na zatváracie tlačidlo sa má dialóg zavrieť.',
      );
    },
  );
}
