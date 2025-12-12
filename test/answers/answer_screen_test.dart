import 'package:biely_kvet/domain/home/answers/answer_screen.dart';
import 'package:biely_kvet/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import '../utils.dart';

void main() {
  Widget wrapScreen(Widget child) {
    return MaterialApp(
      home: Scaffold(body: child),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('sk')],
    );
  }

  testWidgets('AnswerScreen – prázdny vstup zobrazí upozornenie', (
    tester,
  ) async {
    await tester.pumpWidget(wrapScreen(AnswerScreen()));

    expect(find.byType(TextField), findsOneWidget);

    await tester.tap(find.text((await slovakAppLocalization).showAnswerBtn));
    await tester.pumpAndSettle();

    var questionInputLabel =
        (await slovakAppLocalization).questionNumberInputLabel;

    var warningSnackBar = find.byType(SnackBar);
    expect(
      find.descendant(
        of: warningSnackBar,
        matching: find.text(questionInputLabel),
      ),
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
      await tester.tap(find.text((await slovakAppLocalization).showAnswerBtn));
      await tester.pumpAndSettle();
      expect(
        find.textContaining('Otázka č. '),
        findsOneWidget,
        reason: 'Po zadaní správneho čísla sa má zobraziť dialóg.',
      );
      var closeBtnLabel = (await slovakAppLocalization).closeBtn;
      expect(find.text(closeBtnLabel), findsOneWidget);

      // zatvorim dialog s odpovedou
      await tester.tap(find.text(closeBtnLabel));
      await tester.pumpAndSettle();
      expect(
        find.text(closeBtnLabel),
        findsNothing,
        reason: 'Po kliknutí na zatváracie tlačidlo sa má dialóg zavrieť.',
      );
    },
  );
}
