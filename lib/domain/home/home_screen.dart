import 'package:biely_kvet/domain/answers/answer_screen.dart';
import 'package:biely_kvet/domain/core/adaptive/adaptive_tabbed_page.dart';
import 'package:biely_kvet/domain/rules/rules_screen.dart';
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTabbedPage(
      tabBarItems: [
        TabBarItem(
          // TODO: asi custom ikonky
          icon: const Icon(CupertinoIcons.question),
          label: 'Odpovede',
          page: AdaptiveTabBarContent(pageContent: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AnswerScreen(),
          )),
        ),
        TabBarItem(
          // TODO: asi custom ikonky
          icon: const Icon(CupertinoIcons.book),
          label: 'Pravidlá',
          page: AdaptiveTabBarContent(pageContent: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RulesScreen(),
          )),
        ),
      ],
    );
  }
}
