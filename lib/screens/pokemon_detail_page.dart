import 'package:flutter/material.dart';

import '../app/app_theme.dart';
import '../data/pokemon_data.dart';
import '../models/pokemon.dart';
import '../widgets/info_panel.dart';
import '../widgets/pokemon_widgets.dart';

class PokemonDetailPage extends StatefulWidget {
  const PokemonDetailPage({
    required this.pokemon,
    required this.isInTeam,
    required this.onToggle,
    super.key,
  });
  final Pokemon pokemon;
  final bool isInTeam;
  final VoidCallback onToggle;
  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  late bool _isInTeam = widget.isInTeam;
  Pokemon get pokemon => widget.pokemon;
  bool get isInTeam => _isInTeam;

  @override
  Widget build(BuildContext context) => DefaultTabController(
    length: 3,
    child: Scaffold(
      appBar: AppBar(
        backgroundColor: paper,
        foregroundColor: ink,
        title: Text(
          pokemon.number,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DetailHero(pokemon: pokemon),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pokemon.name,
                  style: Theme.of(context).textTheme.headlineMedium
                      ?.copyWith(fontSize: 30),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 7,
                  runSpacing: 5,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    ...pokemon.types.map((t) => TypeBadge(type: t)),
                    Text(
                      '${pokemon.height.toStringAsFixed(1)} m · ${pokemon.weight.toStringAsFixed(1)} kg',
                      style: const TextStyle(color: muted),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                color: lavender,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const TabBar(
                labelColor: brand,
                unselectedLabelColor: muted,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                ),
                dividerColor: Colors.transparent,
                tabs: [
                  Tab(text: 'Statistik'),
                  Tab(text: 'Kemampuan'),
                  Tab(text: 'Evolusi'),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _StatsTab(pokemon: pokemon),
                _AbilitiesTab(pokemon: pokemon),
                _EvolutionTab(pokemon: pokemon),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(20, 8, 20, 12),
        child: FilledButton.icon(
          onPressed: () {
            widget.onToggle();
            setState(() => _isInTeam = !_isInTeam);
          },
          icon: Icon(isInTeam ? Icons.remove : Icons.add),
          label: Text(isInTeam ? 'Hapus dari Tim' : 'Tambah ke Tim'),
          style: FilledButton.styleFrom(
            backgroundColor: brand,
            minimumSize: const Size.fromHeight(54),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
    ),
  );
}

class _DetailHero extends StatelessWidget {
  const _DetailHero({required this.pokemon});
  final Pokemon pokemon;
  @override
  Widget build(BuildContext context) => Container(
    height: 184,
    margin: const EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(
      color: Color(typeColors[pokemon.types.first] ?? 0xFFE6E7FA),
      borderRadius: BorderRadius.circular(26),
    ),
    child: Stack(
      children: [
        Positioned(
          right: -25,
          top: -30,
          child: Icon(
            Icons.catching_pokemon,
            size: 170,
            color: Colors.white.withValues(alpha: .3),
          ),
        ),
        Center(child: PokemonArtwork(pokemon: pokemon, padding: 8)),
      ],
    ),
  );
}

class _StatsTab extends StatelessWidget {
  const _StatsTab({required this.pokemon});
  final Pokemon pokemon;
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
    children: [
      InfoPanel(
        title: 'Tentang ${pokemon.name}',
        child: Text(pokemon.description, style: const TextStyle(height: 1.5)),
      ),
      const SizedBox(height: 12),
      InfoPanel(
        title: 'Statistik dasar',
        child: Column(
          children: pokemon.stats.entries
              .map((e) => _StatRow(label: e.key, value: e.value))
              .toList(),
        ),
      ),
    ],
  );
}

class _AbilitiesTab extends StatelessWidget {
  const _AbilitiesTab({required this.pokemon});
  final Pokemon pokemon;
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
    children: [
      InfoPanel(
        title: 'Kemampuan',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Kemampuan yang dikenal dari Pokémon ini.',
              style: TextStyle(color: muted),
            ),
            const SizedBox(height: 12),
            ...pokemon.abilities.map(
              (a) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    const Icon(Icons.auto_awesome, color: brand, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      a,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      InfoPanel(
        title: 'Komposisi tipe',
        child: Wrap(
          spacing: 8,
          children: pokemon.types.map((t) => TypeBadge(type: t)).toList(),
        ),
      ),
    ],
  );
}

class _EvolutionTab extends StatelessWidget {
  const _EvolutionTab({required this.pokemon});
  final Pokemon pokemon;
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
    children: [
      InfoPanel(
        title: 'Jalur evolusi',
        child: pokemon.evolution.length == 1
            ? Text(
                '${pokemon.name} tidak memiliki evolusi dalam data contoh ini.',
                style: const TextStyle(color: muted),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (var i = 0; i < pokemon.evolution.length; i++) ...[
                      if (i > 0)
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Icon(
                            Icons.arrow_forward,
                            color: muted,
                            size: 18,
                          ),
                        ),
                      _EvolutionNode(
                        name: pokemon.evolution[i],
                        current: i == pokemon.evolution.length - 1,
                      ),
                    ],
                  ],
                ),
              ),
      ),
      const SizedBox(height: 12),
      InfoPanel(
        title: 'Tipe Pokémon',
        child: Wrap(
          spacing: 8,
          children: pokemon.types.map((t) => TypeBadge(type: t)).toList(),
        ),
      ),
    ],
  );
}

class _StatRow extends StatelessWidget {
  const _StatRow({required this.label, required this.value});
  final String label;
  final int value;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: [
        SizedBox(
          width: 70,
          child: Text(
            label,
            style: const TextStyle(
              color: muted,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          width: 30,
          child: Text(
            '$value',
            style: const TextStyle(color: ink, fontWeight: FontWeight.w800),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: (value / 160).clamp(0.0, 1.0).toDouble(),
              minHeight: 8,
              backgroundColor: lavender,
              color: brand,
            ),
          ),
        ),
      ],
    ),
  );
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.label,
    required this.value,
    required this.icon,
  });
  final String label, value;
  final IconData icon;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(13),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: const Color(0xFFEDECF0)),
    ),
    child: Row(
      children: [
        Icon(icon, color: brand),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: muted, fontSize: 12)),
            Text(
              value,
              style: const TextStyle(color: ink, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ],
    ),
  );
}

class _EvolutionNode extends StatelessWidget {
  const _EvolutionNode({required this.name, required this.current});
  final String name;
  final bool current;
  @override
  Widget build(BuildContext context) => Column(
    children: [
      Container(
        width: 62,
        height: 62,
        decoration: BoxDecoration(
          color: current ? lavender : paper,
          shape: BoxShape.circle,
          border: Border.all(
            color: current ? brand : const Color(0xFFE1E1EA),
            width: current ? 2 : 1,
          ),
        ),
        child: Center(
          child: Text(
            name.characters.first.toUpperCase(),
            style: const TextStyle(
              color: brand,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
      const SizedBox(height: 5),
      SizedBox(
        width: 76,
        child: Text(
          name,
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            color: current ? brand : ink,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ],
  );
}
