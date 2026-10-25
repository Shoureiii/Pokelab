import 'package:flutter/material.dart';

import '../app/app_theme.dart';
import '../models/pokemon.dart';
import '../widgets/info_panel.dart';
import '../widgets/pokemon_widgets.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({
    required this.team,
    required this.onRemove,
    required this.onAdd,
    required this.onOpen,
    super.key,
  });
  final List<Pokemon> team;
  final ValueChanged<Pokemon> onRemove;
  final VoidCallback onAdd;
  final ValueChanged<Pokemon> onOpen;
  @override
  Widget build(BuildContext context) {
    final coverage = <String>{for (final p in team) ...p.types}.toList()
      ..sort();
    final weak = <String, List<MapEntry<Pokemon, double>>>{};
    for (final p in team) {
      for (final e in p.weaknesses.entries) {
        weak.putIfAbsent(e.key, () => []).add(MapEntry(p, e.value));
      }
    }
    final ranked = weak.entries.toList()
      ..sort((a, b) {
        final c = b.value.length.compareTo(a.value.length);
        if (c != 0) return c;
        return b.value
            .fold<double>(0, (s, x) => s + x.value)
            .compareTo(a.value.fold<double>(0, (s, x) => s + x.value));
      });
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
      children: [
        Text(
          'Tim Saya',
          style: Theme.of(context).textTheme.headlineMedium
              ?.copyWith(fontSize: 30),
        ),
        const SizedBox(height: 4),
        Text(
          '${team.length} dari 6 slot terisi',
          style: const TextStyle(color: muted),
        ),
        const SizedBox(height: 14),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 6,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.42,
          ),
          itemBuilder: (context, i) => i >= team.length
              ? _EmptyTeamSlot(onTap: onAdd)
              : _TeamMemberCard(
                  pokemon: team[i],
                  onTap: () => onOpen(team[i]),
                  onRemove: () => onRemove(team[i]),
                ),
        ),
        const SizedBox(height: 18),
        InfoPanel(
          title: 'Tipe yang tercakup',
          child: coverage.isEmpty
              ? const Text('Tambahkan Pokémon untuk melihat komposisi tipe.')
              : Wrap(
                  spacing: 7,
                  runSpacing: 8,
                  children: coverage.map((t) => TypeBadge(type: t)).toList(),
                ),
        ),
        const SizedBox(height: 12),
        _WeaknessPanel(ranked: ranked.take(3).toList(), empty: team.isEmpty),
        const SizedBox(height: 8),
        const Text(
          'Analisis sederhana berdasarkan tipe Pokémon.',
          style: TextStyle(color: muted, fontSize: 12),
        ),
      ],
    );
  }
}

class _TeamMemberCard extends StatelessWidget {
  const _TeamMemberCard({
    required this.pokemon,
    required this.onTap,
    required this.onRemove,
  });
  final Pokemon pokemon;
  final VoidCallback onTap, onRemove;
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(20),
    child: Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEDECF0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  pokemon.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: ink,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              IconButton(
                onPressed: onRemove,
                visualDensity: VisualDensity.compact,
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.close, color: muted, size: 18),
              ),
            ],
          ),
          const Spacer(),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: pokemon.types
                .map((t) => TypeBadge(type: t, compact: true))
                .toList(),
          ),
        ],
      ),
    ),
  );
}

class _EmptyTeamSlot extends StatelessWidget {
  const _EmptyTeamSlot({required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => OutlinedButton(
    onPressed: onTap,
    style: OutlinedButton.styleFrom(
      foregroundColor: brand,
      side: const BorderSide(color: Color(0xFFB7B9D6)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    child: const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.add, size: 23),
        SizedBox(height: 4),
        Text(
          'Tambah Pokémon',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
        ),
      ],
    ),
  );
}

class _WeaknessPanel extends StatelessWidget {
  const _WeaknessPanel({required this.ranked, required this.empty});
  final List<MapEntry<String, List<MapEntry<Pokemon, double>>>> ranked;
  final bool empty;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF0E8),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.shield_outlined, color: Color(0xFF9C3D12)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                empty ? 'Belum ada analisis tim' : 'Perhatikan kelemahan tipe',
                style: const TextStyle(
                  color: Color(0xFF7A3519),
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (empty)
          const Text(
            'Tambahkan Pokémon untuk melihat analisis komposisi tim.',
            style: TextStyle(color: Color(0xFF7A3519)),
          )
        else if (ranked.isEmpty)
          const Text(
            'Belum ada kelemahan tipe yang tercatat.',
            style: TextStyle(color: Color(0xFF7A3519)),
          )
        else
          ...ranked.map((e) {
            final names = e.value
                .map(
                  (x) =>
                      '${x.key.name}${x.value >= 4 ? ' (${x.value.toStringAsFixed(0)}×)' : ''}',
                )
                .join(', ');
            return Padding(
              padding: const EdgeInsets.only(top: 7),
              child: Text(
                '${e.key}: $names',
                style: const TextStyle(color: Color(0xFF7A3519), fontSize: 13),
              ),
            );
          }),
      ],
    ),
  );
}
