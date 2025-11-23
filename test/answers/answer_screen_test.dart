import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:biely_kvet/domain/answers/answer_screen.dart';

void main() {
  Widget wrapScreen(Widget child) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets(
      'AnswerScreen – prázdny vstup zobrazí upozornenie', (tester) async {
    await tester.pumpWidget(wrapScreen(const AnswerScreen()));

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
}
