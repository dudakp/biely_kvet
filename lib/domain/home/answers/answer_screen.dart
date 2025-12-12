import 'package:adaptive_widgets_flutter/adaptive_widgets.dart';
import 'package:biely_kvet/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AnswerScreen extends StatefulWidget {
  const AnswerScreen({super.key});

  @override
  State<AnswerScreen> createState() => _AnswerScreenState();
}

class _AnswerScreenState extends State<AnswerScreen> {
  final TextEditingController _questionController = TextEditingController();

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }

  Future<void> _showAnswer() async {
    final raw = _questionController.text.trim();

    if (raw.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text(AppLocalizations.of(context)!.questionNumberInputLabel)),
      );
      return;
    }

    final number = int.tryParse(raw);
    if (number == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('To ani nie je číslo…')));
      return;
    }

    FocusScope.of(context).unfocus();

    final answer = 'Odpoveď na otázku $number (raz pôjde z DB).';

    await AdaptiveWidgets.showBottomActionSheet(
      context,
      title: Text('Otázka č. $number'),
      message: Text(answer, textAlign: TextAlign.center),
      actionButtons: [
        AdaptiveBottomSheetButtonBuilder(
          child: const Text('Zatvoriť'),
          isCancelAction: true,
          onPressed: (ctx) => Navigator.of(ctx).pop(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: _questionController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: AppLocalizations.of(context)!.questionNumberInputLabel,
          ),
        ),
        const SizedBox(height: 12),
        FilledButton(onPressed: _showAnswer, child:  Text(AppLocalizations.of(context)!.showAnswerBtn)),
      ],
    );
  }
}
