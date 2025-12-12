import 'package:flutter/material.dart';

import '../domain/home/answers/answer_screen.dart';
import '../domain/home/home_screen.dart';
import '../domain/home/rules/rules_screen.dart';

class Routes {
  static const home = '/';
  static const answers = '/answers';
  static const rules = '/rules';

  static Map<String, WidgetBuilder> all = {
    home: (_) => const HomeScreen(),
    answers: (_) => const AnswerScreen(),
    rules: (_) => RulesScreen(),
  };
}
