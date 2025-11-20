import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:biely_kvet/main.dart';

void main() {
  testWidgets('App nacita hlavne UI', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Biely kvet - Dano Drevo companion'), findsOneWidget);

    expect(find.text('Daj číslo otázky ty bazerant'), findsOneWidget);

    expect(find.text('Ukáž'), findsOneWidget);

    expect(find.byIcon(Icons.hourglass_top_rounded), findsOneWidget);
  });
}
