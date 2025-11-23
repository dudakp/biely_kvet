import 'package:flutter/material.dart';
import '../domain/home/home_screen.dart';
import '../domain/answers/answer_screen.dart';
import '../domain/timer/timer_screen.dart';
import '../domain/rules/rules_screen.dart';

class Routes {
  static const home = '/';
  static const answers = '/answers';
  static const timer = '/timer';
  static const rules = '/rules';

  static Map<String, WidgetBuilder> all = {
    home: (_) => const HomeScreen(),
    answers: (_) => const AnswerScreen(),
    timer: (_) => const TimerScreen(),
    rules: (_) => const RulesScreen(),
  };
}
