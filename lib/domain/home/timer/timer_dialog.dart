import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

class TimerRunningDialog extends StatefulWidget {
  const TimerRunningDialog({super.key});

  @override
  State<TimerRunningDialog> createState() => _TimerRunningDialogState();
}

class _TimerRunningDialogState extends State<TimerRunningDialog> {
  Timer? _timer;
  int _remainingSeconds = 0;
  int _initialSeconds = 0;
  bool _isTimerActive = false;
  static const _timerDuration = 3;
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
    _isTimerActive = true;
    if (_remainingSeconds <= 0) {
      _setSeconds(_timerDuration);
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
    return showDialog(
      context: context,
      builder: (context) => TimerDoneDialog(),
    );
  }


  void _closeTimerDialog(StateSetter setState, BuildContext context) {
    setState(() {
      _isTimerActive = false;
    });
    Navigator.of(context).pop();
    _resetTimer();
  }

  String get _formatted {
    final m = _remainingSeconds ~/ 60;
    final s = _remainingSeconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _start();
    });
    var stopTimerLabel = const Text('Stop');
    return AlertDialog.adaptive(
      actions: [
        // TODO: asi pre iIOS toto nebude vhodne, pouzit CupertinoDialogAction
        Platform.isIOS
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
      content: StreamBuilder(
        stream: _events.stream,
        builder: (context, snapshot) => Text(_formatted),
      ),
    )
    as Widget;
  }
}


class TimerDoneDialog extends StatelessWidget {
  const TimerDoneDialog({super.key});

  @override
  Widget build(BuildContext context) {
    var finishedDialogBody = Text(
      AppLocalizations.of(context)!.timerDoneButtonLabel,
    );
    return AlertDialog.adaptive(
      title: Text(AppLocalizations.of(context)!.timerDialogTitle),
      content: Text(AppLocalizations.of(context)!.timerDoneText),
      actions: [
        Platform.isIOS
            ? CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: finishedDialogBody,
              )
            : TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: finishedDialogBody,
              ),
      ],
    );
  }
}
