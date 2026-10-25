class Pokemon {
  const Pokemon({
    required this.id,
    required this.name,
    required this.types,
    required this.height,
    required this.weight,
    required this.abilities,
    required this.stats,
    required this.description,
    required this.evolution,
    required this.weaknesses,
  });

  final int id;
  final String name;
  final List<String> types;
  final double height;
  final double weight;
  final List<String> abilities;
  final Map<String, int> stats;
  final String description;
  final List<String> evolution;
  final Map<String, double> weaknesses;

  String get number => '#${id.toString().padLeft(3, '0')}';

  String get artworkUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
}
