import 'package:flutter/material.dart';

import '../app/app_theme.dart';
import '../data/pokemon_data.dart';
import '../models/pokemon.dart';
import '../widgets/info_panel.dart';
import '../widgets/pokemon_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    required this.team,
    required this.onNavigate,
    required this.onOpen,
    super.key,
  });
  final List<Pokemon> team;
  final ValueChanged<int> onNavigate;
  final ValueChanged<Pokemon> onOpen;
  @override
  Widget build(BuildContext context) {
    final featured = starterPokemon.firstWhere((p) => p.id == 6);
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
      children: [
        Text(
          'Halo, Trainer!',
          style: Theme.of(context).textTheme.headlineMedium
              ?.copyWith(fontSize: 30),
        ),
        const SizedBox(height: 4),
        const Text(
          'Mau mempelajari Pokémon apa hari ini?',
          style: TextStyle(color: muted),
        ),
        const SizedBox(height: 18),
        SearchBar(
          hintText: 'Cari nama atau nomor Pokémon',
          leading: const Icon(Icons.search, color: muted),
          elevation: const WidgetStatePropertyAll(0),
          backgroundColor: const WidgetStatePropertyAll(Colors.white),
          side: const WidgetStatePropertyAll(
            BorderSide(color: Color(0xFFDCDDEA)),
          ),
          onTap: () => onNavigate(1),
        ),
        const SizedBox(height: 18),
        _SectionHeading(
          'Temuan Hari Ini',
          'Lihat detail',
          () => onOpen(featured),
        ),
        const SizedBox(height: 8),
        _FeaturedCard(pokemon: featured, onTap: () => onOpen(featured)),
        const SizedBox(height: 18),
        _ExploreCard(onTap: () => onNavigate(1)),
        const SizedBox(height: 18),
        _SectionHeading(
          'Tim Saya',
          '${team.length} dari 6 slot',
          () => onNavigate(2),
        ),
        const SizedBox(height: 8),
        _TeamPreview(team: team, onTap: () => onNavigate(2)),
      ],
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading(this.title, this.action, this.onTap);
  final String title, action;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: Text(
          title,
          style: const TextStyle(
            color: ink,
            fontSize: 17,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      TextButton(
        onPressed: onTap,
        child: Text(
          action,
          style: const TextStyle(
            color: brand,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ],
  );
}

class _FeaturedCard extends StatelessWidget {
  const _FeaturedCard({required this.pokemon, required this.onTap});
  final Pokemon pokemon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Card(
    color: Colors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
      side: const BorderSide(color: Color(0xFFEDECF0)),
    ),
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: Color(typeColors[pokemon.types.first] ?? 0xFFE6E7FA),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: PokemonArtwork(pokemon: pokemon, padding: 4),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: lavender,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text(
                        'Temuan Hari Ini',
                        style: TextStyle(
                          color: brand,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      pokemon.name,
                      style: const TextStyle(
                        color: ink,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      pokemon.number,
                      style: const TextStyle(
                        color: muted,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 5,
                      children: pokemon.types
                          .map((t) => TypeBadge(type: t, compact: true))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            pokemon.description,
            style: const TextStyle(color: ink, height: 1.45),
          ),
          const SizedBox(height: 11),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onTap,
              style: FilledButton.styleFrom(
                backgroundColor: brand,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text('Lihat detail'),
            ),
          ),
        ],
      ),
    ),
  );
}

class _ExploreCard extends StatelessWidget {
  const _ExploreCard({required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Card(
    color: Colors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: const BorderSide(color: Color(0xFFEDECF0)),
    ),
    child: ListTile(
      onTap: onTap,
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: lavender,
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Icon(Icons.grid_view_rounded, color: brand),
      ),
      title: const Text(
        'Jelajahi Pokédex',
        style: TextStyle(fontWeight: FontWeight.w800, color: ink),
      ),
      subtitle: const Text(
        'Cari dan saring Pokémon berdasarkan tipe',
        style: TextStyle(color: muted),
      ),
      trailing: const Icon(Icons.chevron_right, color: muted),
    ),
  );
}

class _TeamPreview extends StatelessWidget {
  const _TeamPreview({required this.team, required this.onTap});
  final List<Pokemon> team;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(20),
    child: Container(
      padding: const EdgeInsets.all(14),
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
              const Expanded(
                child: Text(
                  'Komposisi tim',
                  style: TextStyle(color: ink, fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              ...team.map((p) => _MiniPokemon(pokemon: p)),
              ...List.generate(6 - team.length, (_) => const _EmptyMiniSlot()),
            ],
          ),
        ],
      ),
    ),
  );
}

class _MiniPokemon extends StatelessWidget {
  const _MiniPokemon({required this.pokemon});
  final Pokemon pokemon;
  @override
  Widget build(BuildContext context) => Container(
    width: 42,
    height: 42,
    decoration: BoxDecoration(
      color: Color(typeColors[pokemon.types.first] ?? 0xFFE6E7FA),
      shape: BoxShape.circle,
    ),
    child: PokemonArtwork(pokemon: pokemon, padding: 3),
  );
}

class _EmptyMiniSlot extends StatelessWidget {
  const _EmptyMiniSlot();
  @override
  Widget build(BuildContext context) => Container(
    width: 42,
    height: 42,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: const Color(0xFFB9BAD7)),
    ),
    child: const Icon(Icons.add, size: 19, color: muted),
  );
}
