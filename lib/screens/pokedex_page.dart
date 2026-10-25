import 'package:flutter/material.dart';

import '../app/app_theme.dart';
import '../data/pokemon_data.dart';
import '../models/pokemon.dart';
import '../widgets/pokemon_widgets.dart';

class PokedexPage extends StatefulWidget {
  const PokedexPage({required this.onOpen, super.key});
  final ValueChanged<Pokemon> onOpen;
  @override
  State<PokedexPage> createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> {
  final search = TextEditingController();
  String selectedType = 'Semua';
  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final q = search.text.trim().toLowerCase();
    final results = starterPokemon
        .where(
          (p) =>
              (selectedType == 'Semua' || p.types.contains(selectedType)) &&
              (p.name.toLowerCase().contains(q) ||
                  p.number.toLowerCase().contains(q) ||
                  p.id.toString() == q),
        )
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Pokédex',
                  style: Theme.of(context).textTheme.headlineMedium
                      ?.copyWith(fontSize: 30),
                ),
              ),
              Text(
                '${results.length} Pokémon',
                style: const TextStyle(
                  color: muted,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            controller: search,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: 'Cari nama atau nomor',
              prefixIcon: const Icon(Icons.search, color: muted),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(color: Color(0xFFDCDDEA)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(color: Color(0xFFDCDDEA)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: const BorderSide(color: brand),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 42,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: pokemonTypes.length,
            separatorBuilder: (_, __) => const SizedBox(width: 7),
            itemBuilder: (context, i) {
              final type = pokemonTypes[i];
              final active = selectedType == type;
              return ChoiceChip(
                label: Text(type),
                selected: active,
                onSelected: (_) => setState(() => selectedType = type),
                selectedColor: brand,
                backgroundColor: Colors.white,
                labelStyle: TextStyle(
                  color: active ? Colors.white : ink,
                  fontWeight: FontWeight.w600,
                ),
                side: BorderSide(
                  color: active ? brand : const Color(0xFFE0E1EA),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: results.isEmpty
              ? const Center(
                  child: Text(
                    'Pokémon tidak ditemukan.',
                    style: TextStyle(color: muted),
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 18),
                  itemCount: results.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.78,
                  ),
                  itemBuilder: (_, i) => PokemonCard(
                    pokemon: results[i],
                    onTap: () => widget.onOpen(results[i]),
                  ),
                ),
        ),
      ],
    );
  }
}
