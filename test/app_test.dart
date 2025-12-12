import 'package:biely_kvet/main.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  testWidgets('App načíta hlavné menu', (tester) async {
    await tester.pumpWidget(const BielyKvetApp());

    expect(
      find.text((await slovakAppLocalization).questionsTabTitle),
      findsOneWidget,
    );
    expect(
      find.text((await slovakAppLocalization).rulesTabTitle),
      findsOneWidget,
    );
  });
}
