import 'dart:async';
import 'dart:io';
import 'package:biely_kvet/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:adaptive_widgets_flutter/adaptive_widgets.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  Timer? _timer;
  int _remainingSeconds = 0;
  int _initialSeconds = 0;

  static const List<int> _presetSeconds = [30, 60, 120];
  final List<int> _recentSeconds = <int>[];

  final TextEditingController _secondsController = TextEditingController(
    text: '60',
  );

  @override
  void dispose() {
    _timer?.cancel();
    _secondsController.dispose();
    super.dispose();
  }

  void _setSeconds(int value) {
    if (value <= 0) return;

    setState(() {
      _initialSeconds = value;
      _remainingSeconds = value;
      _secondsController.text = value.toString();

      _recentSeconds.remove(value);
      _recentSeconds.insert(0, value);
      if (_recentSeconds.length > 3) {
        _recentSeconds.removeLast();
      }
    });
  }

  void _applyInput() {
    final raw = _secondsController.text.trim();
    final parsed = int.tryParse(raw);

    if (parsed == null || parsed <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Daj kladné číslo sekúnd, bazerant.')),
      );
      return;
    }

    _setSeconds(parsed);
  }

  Future<void> _showFinishedDialog() {
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

  void _start() {
    if (_remainingSeconds <= 0) {
      _applyInput();
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
        });
      }
    });
  }

  void _stop() {
    _timer?.cancel();
  }

  void _reset() {
    _timer?.cancel();
    setState(() {
      _remainingSeconds = _initialSeconds;
    });
  }

  String get _formatted {
    final m = _remainingSeconds ~/ 60;
    final s = _remainingSeconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
        return Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Rýchly výber',
                style: textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: _presetSeconds
                  .map((sec) =>
                  Platform.isIOS ? CupertinoButton(
                  onPressed: () => _setSeconds(sec),
                  child: Text('${sec}s'),
                )
                  : OutlinedButton(
                    onPressed: () => _setSeconds(sec),
                    child: Text('${sec}s'),
                  )
              )
                  .toList(),
            ),
            const SizedBox(height: 16),
            if (_recentSeconds.isNotEmpty) ...[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Naposledy použité',
                  style: textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: _recentSeconds
                    .map(
                      (sec) => FilledButton.tonal(
                    onPressed: () => _setSeconds(sec),
                    child: Text('${sec}s'),
                  ),
                )
                    .toList(),
              ),
              const SizedBox(height: 16),
            ],
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _secondsController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Čas v sekundách',
                    ),
                    onSubmitted: (_) => _applyInput(),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: _applyInput,
                  child: const Text('Nastav'),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Text(
              _formatted,
              style: textTheme.displayMedium,
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              children: [
                FilledButton(onPressed: _start, child: const Text('Štart')),
                FilledButton(onPressed: _stop, child: const Text('Stop')),
                OutlinedButton(onPressed: _reset, child: const Text('Reset')),
              ],
            ),
    ]);
  }
}
