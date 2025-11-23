import 'package:flutter/material.dart';
import 'package:adaptive_widgets_flutter/adaptive_widgets.dart';

class RulesScreen extends StatelessWidget {
  const RulesScreen({super.key});

  Widget _section(TextTheme theme, String title, String body) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: theme.bodyMedium,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Pravidlá hry')),
      body: AdaptiveRefreshableScrollView(
        padding: const EdgeInsets.all(16),
        onRefresh: () async {
          await Future<void>.delayed(const Duration(milliseconds: 300));
        },
        slivers: [
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pravidlá hry Biely kvet',
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _section(
                      textTheme,
                      'PRIEBEH HRY',
                      '• Hráč si potiahne kartičku s otázkou alebo aktivitou.\n'
                          '• Ak odpovie správne, získava 1 bod a kartičku si nechá.\n'
                          '• Ak odpovie nesprávne, kartička ide na kopu neuhádnutých kariet.',
                    ),
                    _section(
                      textTheme,
                      'AKTIVITY',
                      '• Hráč si potiahne kartičku s aktivitou, hodí kockou a podľa hodeného čísla '
                          'vykoná úlohu spojenú s danou postavou.\n\n'
                          'Príklad:\n'
                          '• Hráč si potiahne kartu „Dano Drevo s kockou“.\n'
                          '• Hodí kockou, padne číslo 2.\n'
                          '• Na hornej doske je pri čísle 2 napísané: „Cituj výrok postavy“.\n'
                          '• Hráč nahlas povie citát postavy Dano Drevo.\n'
                          '• Kto ako prvý z protihráčov uhádne postavu, získava 1 bod, rovnako ako hráč, '
                          'ktorý aktivitu vykonal.\n'
                          '• Ak hráč aktivitu nedokáže vykonať, karta ide na kopu neuhádnutých kariet '
                          'a hra pokračuje ďalším hráčom.',
                    ),
                    _section(
                      textTheme,
                      'BONUSY',
                      '• ČIERNY PEDER – hráč automaticky stráca 1 bod, pokračuje ďalší hráč.\n'
                          '• ŠŤASTNÁ 6 – hráč automaticky získava 1 bod, pokračuje ďalší hráč.',
                    ),
                    _section(
                      textTheme,
                      'SPÔSOB HRY',
                      '• Primárne je hra určená pre jednotlivcov – každý hrá za seba.\n'
                          '• Po dohode je možné hrať aj v tímoch po 2 hráčoch.\n'
                          '  – V tímovom režime sa hráči striedajú v ťahaní kariet a body sa rátajú za tím.\n'
                          '  – Pri aktivitách jeden z tímu plní aktivitu a druhý háda, o ktorú postavu ide (+1 bod pre tím).',
                    ),
                    _section(
                      textTheme,
                      'HERNÉ REŽIMY',
                      'Hráči si na začiatku zvolia jeden z dvoch herných režimov:\n\n'
                          '1. Na kolá:\n'
                          '   • Kolo končí, keď hráč získa 30 bodov alebo po 30 minútach hry.\n\n'
                          '2. Do vyčerpania kariet:\n'
                          '   • Hrá sa, kým sa neminú všetky kartičky (vrátane tých, ktoré sa zamiešajú z kopy neuhádnutých).',
                    ),
                    _section(
                      textTheme,
                      'OPAKOVANIE OTÁZOK',
                      '• Po spotrebovaní zodpovedaných kariet sa neuhádnuté zamiešajú a hra pokračuje.',
                    ),
                    _section(
                      textTheme,
                      'VÍŤAZSTVO',
                      '• Hra končí po splnení zvoleného cieľa (čas, body alebo prázdna kôpka).\n'
                          '• Víťazom je hráč s najvyšším počtom bodov.',
                    ),
                    _section(
                      textTheme,
                      'HERNÁ DOSKA',
                      '• Na hernej doske sú 2 odkladacie priestory na karty:\n'
                          '  1. slúži na všetky karty od začiatku hry.\n'
                          '  2. na neuhádnuté karty.\n\n'
                          '• Každá otázka je za 1 bod.',
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
