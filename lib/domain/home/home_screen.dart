import 'package:flutter/material.dart';
import 'package:adaptive_widgets_flutter/adaptive_widgets.dart';
import '../../config/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _showInfoDialog(BuildContext context) {
    return AdaptiveWidgets.showDialog(
      context,
      title: 'Biely kvet',
      content: 'Dano Drevo companion app.\n\nVyber si, čo chceš robiť, ty bazerant.',
      actionButtons: [
        AdaptiveDialogButtonBuilder(
          text: 'OK',
          onPressed: (ctx) => Navigator.of(ctx).pop(),
        ),
      ],
    );
  }

  Widget _menuButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String route,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: FilledButton.icon(
        onPressed: () => Navigator.pushNamed(context, route),
        icon: Icon(icon),
        label: Text(label),
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 18),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biely kvet'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'Info',
            onPressed: () => _showInfoDialog(context),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 380),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _menuButton(
                  context: context,
                  icon: Icons.search,
                  label: 'Hľadať odpoveď',
                  route: Routes.answers,
                ),
                _menuButton(
                  context: context,
                  icon: Icons.timer,
                  label: 'Časovač',
                  route: Routes.timer,
                ),
                _menuButton(
                  context: context,
                  icon: Icons.rule,
                  label: 'Pravidlá hry',
                  route: Routes.rules,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
