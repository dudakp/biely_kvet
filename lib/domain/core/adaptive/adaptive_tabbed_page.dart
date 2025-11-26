import 'dart:async';

import 'package:adaptive_widgets_flutter/adaptive_widgets.dart';
import 'package:biely_kvet/domain/core/adaptive/platform_aware.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabBarItem {
  final Widget icon;
  final Widget? activeIcon;
  final String label;
  final AdaptiveTabBarContent page;

  TabBarItem({
    required this.icon,
    required this.label,
    this.activeIcon,
    required this.page,
  });
}

class AdaptiveTabBarContent extends PlatformAwareStatelessWidget {
  final Widget pageContent;

  AdaptiveTabBarContent({super.key, required this.pageContent});

  @override
  Widget buildAndroid(BuildContext context) {
    return pageContent;
  }

  @override
  Widget buildIos(BuildContext context) {
    return CupertinoTabView(builder: (context) => pageContent);
  }
}

class AdaptiveTabbedPage extends PlatformAwareStatefulWidget {
  final List<TabBarItem> tabBarItems;

  AdaptiveTabbedPage({super.key, required this.tabBarItems});

  @override
  State<AdaptiveTabbedPage> createState() => _AdaptiveTabbedPageState();
}

class _AdaptiveTabbedPageState
    extends PlatformAwareStatefulWidgetState<AdaptiveTabbedPage> {
  int currentPageIndex = 0;

  Timer? _timer;
  int _remainingSeconds = 0;
  int _initialSeconds = 0;
  bool _isTimerActive = false;

  late StreamController<int> _events;

  @override
  initState() {
    super.initState();
    _events = StreamController<int>.broadcast();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _events.close();
    super.dispose();
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _remainingSeconds = _initialSeconds;
    });
  }

  void _setSeconds(int value) {
    if (value <= 0) return;

    setState(() {
      _initialSeconds = value;
      _remainingSeconds = value;
    });
  }

  void _start() {
    if (_remainingSeconds <= 0) {
      // _applyInput();
      _setSeconds(3);
      if (_remainingSeconds <= 0) return;
    }

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) async {
      if (!mounted) {
        _timer?.cancel();
        return;
      }

      if (_remainingSeconds <= 1) {
        setState(() {
          _remainingSeconds = 0;
        });
        _timer?.cancel();
        await _showFinishedDialog();
      } else {
        setState(() {
          _remainingSeconds--;
          _events.add(_remainingSeconds);
        });
      }
    });
  }

  Future<void> _showFinishedDialog() {
    if (_isTimerActive) {
      Navigator.of(context).pop();
    }
    return AdaptiveWidgets.showDialog(
      context,
      title: 'Časovač',
      content: 'Koniec, bazerant.',
      actionButtons: [
        AdaptiveDialogButtonBuilder(
          text: 'OK',
          onPressed: (ctx) => Navigator.of(ctx).pop(),
        ),
      ],
    );
  }

  String get _formatted {
    final m = _remainingSeconds ~/ 60;
    final s = _remainingSeconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget buildAndroid(BuildContext context) {
    var allPages = widget.tabBarItems.map((e) => e.page).toList();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            _isTimerActive = true;
          });
          _start();
          await showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setState) {
                  var stopTimerLabel = const Text('Stop');
                  return AlertDialog.adaptive(
                        actions: [
                          // TODO: asi pre iIOS toto nebude vhodne, pouzit CupertinoDialogAction
                          PlatformAware().isIOS
                              ? CupertinoDialogAction(
                                  onPressed: () {
                                    _closeTimerDialog(setState, context);
                                  },
                                  child: stopTimerLabel,
                                )
                              : TextButton(
                                  onPressed: () {
                                    _closeTimerDialog(setState, context);
                                  },
                                  child: stopTimerLabel,
                                ),
                        ],
                        title: const Text('Časovač'),
                        // dismissible: false,
                        content: StreamBuilder(
                          stream: _events.stream,
                          builder: (context, snapshot) => Text(_formatted),
                        ),
                      )
                      as Widget;
                },
              );
            },
          );
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

      /// Home page
    );
  }

  void _closeTimerDialog(StateSetter setState, BuildContext context) {
    setState(() {
      _isTimerActive = false;
    });
    Navigator.of(context).pop();
    _resetTimer();
  }

  @override
  Widget buildIos(BuildContext context) {
    var allPages = widget.tabBarItems.map((e) => e.page).toList();
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: widget.tabBarItems
            .map(
              (item) => BottomNavigationBarItem(
                icon: item.icon,
                label: item.label,
                activeIcon: item.activeIcon,
              ),
            )
            .toList(),
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            return CupertinoPageScaffold(child: allPages[index]);
          },
        );
      },
    );
  }
}
