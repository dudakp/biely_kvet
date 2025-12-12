import 'package:biely_kvet/main.dart';
import 'package:flutter_test/flutter_test.dart';

import '../utils.dart';

void main() {
  testWidgets('Navigácia na AnswerScreen funguje', (tester) async {
    await tester.pumpWidget(const BielyKvetApp());

    await tester.tap(
      find.text((await slovakAppLocalization).questionsTabTitle),
    );
    await tester.pumpAndSettle();

    expect(
      find.text((await slovakAppLocalization).questionNumberInputLabel),
      findsOneWidget,
    );
    expect(
      find.text((await slovakAppLocalization).showAnswerBtn),
      findsOneWidget,
    );
  });

  testWidgets('Navigácia na RulesScreen funguje', (tester) async {
    await tester.pumpWidget(const BielyKvetApp());

    await tester.tap(find.text((await slovakAppLocalization).rulesTabTitle));
    await tester.pumpAndSettle();

    expect(
      find.text((await slovakAppLocalization).rulesTabTitle),
      findsOneWidget,
    );
    expect(find.text('Pravidlá hry Biely kvet'), findsOneWidget);
  });
}
