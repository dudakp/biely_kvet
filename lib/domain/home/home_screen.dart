import 'dart:async';

import 'package:biely_kvet/domain/home/rules/rules_screen.dart';
import 'package:biely_kvet/domain/home/timer/timer_dialog.dart';
import 'package:biely_kvet/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'answers/answer_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TabbedPage(
      tabBarItems: [
        TabBarItem(
          // TODO: asi custom ikonky
          icon: const Icon(CupertinoIcons.question),
          label: AppLocalizations.of(context)!.questionsTabTitle,
          page: TabBarContent(
            pageContent: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnswerScreen(),
            ),
          ),
        ),
        TabBarItem(
          // TODO: asi custom ikonky
          icon: const Icon(CupertinoIcons.book),
          label: AppLocalizations.of(context)!.rulesTabTitle,
          page: TabBarContent(
            pageContent: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RulesScreen(),
            ),
          ),
        ),
      ],
    );
  }
}

class TabBarItem {
  final Widget icon;
  final Widget? activeIcon;
  final String label;
  final TabBarContent page;

  TabBarItem({
    required this.icon,
    required this.label,
    this.activeIcon,
    required this.page,
  });
}

class TabBarContent extends StatelessWidget {
  final Widget pageContent;

  const TabBarContent({super.key, required this.pageContent});

  @override
  Widget build(BuildContext context) {
    return pageContent;
  }
}

class TabbedPage extends StatefulWidget {
  final List<TabBarItem> tabBarItems;

  const TabbedPage({super.key, required this.tabBarItems});

  @override
  State<TabbedPage> createState() => _AdaptiveTabbedPageState();
}

class _AdaptiveTabbedPageState extends State<TabbedPage> {
  int currentPageIndex = 0;

  Future<void> _showTimerRunningDialog() async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => TimerRunningDialog(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var allPages = widget.tabBarItems.map((e) => e.page).toList();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _showTimerRunningDialog();
        },
        shape: CircleBorder(),
        child: Icon(Icons.timer),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: widget.tabBarItems
            .map(
              (item) => NavigationDestination(
                icon: item.icon,
                label: item.label,
                selectedIcon: item.activeIcon,
              ),
            )
            .toList(),
      ),
      body: allPages[currentPageIndex],
    );
  }
}
