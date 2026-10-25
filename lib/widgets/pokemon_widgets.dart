import 'package:flutter/material.dart';

import '../app/app_theme.dart';
import '../models/pokemon.dart';
import '../data/pokemon_data.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({required this.pokemon, required this.onTap, super.key});
  final Pokemon pokemon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Card(
    color: Colors.white,
    elevation: 0,
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(22),
      side: const BorderSide(color: Color(0xFFEDECF0)),
    ),
    child: InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(typeColors[pokemon.types.first] ?? 0xFFE6E7FA),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: PokemonArtwork(pokemon: pokemon, padding: 8),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              pokemon.number,
              style: const TextStyle(color: muted, fontSize: 12),
            ),
            Text(
              pokemon.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: ink,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 5),
            Wrap(
              spacing: 5,
              runSpacing: 4,
              children: pokemon.types
                  .map((t) => TypeBadge(type: t, compact: true))
                  .toList(),
            ),
          ],
        ),
      ),
    ),
  );
}

class PokemonArtwork extends StatelessWidget {
  const PokemonArtwork({required this.pokemon, this.padding = 0, super.key});
  final Pokemon pokemon;
  final double padding;
  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.all(padding),
    child: Image.network(
      pokemon.artworkUrl,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => Center(
        child: Text(
          pokemon.name.characters.first,
          style: const TextStyle(
            color: brand,
            fontSize: 54,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    ),
  );
}

class TypeBadge extends StatelessWidget {
  const TypeBadge({required this.type, this.compact = false, super.key});
  final String type;
  final bool compact;
  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(
      horizontal: compact ? 9 : 11,
      vertical: compact ? 4 : 6,
    ),
    decoration: BoxDecoration(
      color: Color(typeColors[type] ?? 0xFFE6E7FA),
      borderRadius: BorderRadius.circular(30),
    ),
    child: Text(
      type,
      style: TextStyle(
        color: Color(typeTextColors[type] ?? 0xFF1E1F4B),
        fontSize: compact ? 11 : 12,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
