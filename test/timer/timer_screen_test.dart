import 'package:flutter_test/flutter_test.dart';
import 'package:biely_kvet/main.dart';

void main() {
  testWidgets('TimerScreen – zobrazuje základné UI', (tester) async {
    await tester.pumpWidget(const BielyKvetApp());

    await tester.tap(find.text('Časovač'));
    await tester.pumpAndSettle();

    expect(find.text('Časovač'), findsOneWidget);
    expect(find.text('Čas v sekundách'), findsOneWidget);
    expect(find.text('Štart'), findsOneWidget);
    expect(find.text('Stop'), findsOneWidget);
    expect(find.text('Reset'), findsOneWidget);
  });
}
