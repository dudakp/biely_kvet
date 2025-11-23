import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:biely_kvet/domain/answers/answer_screen.dart';

void main() {
  Widget _wrap(Widget child) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('AnswerScreen', (tester) async {
    await tester.pumpWidget(_wrap(const AnswerScreen()));

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
