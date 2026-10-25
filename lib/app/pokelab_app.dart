import 'package:flutter/material.dart';

import '../data/pokemon_data.dart';
import '../models/pokemon.dart';
import '../screens/home_page.dart';
import '../screens/pokedex_page.dart';
import '../screens/pokemon_detail_page.dart';
import '../screens/team_page.dart';
import 'app_theme.dart';

class PokelabApp extends StatefulWidget {
  const PokelabApp({super.key});

  @override
  State<PokelabApp> createState() => _PokelabAppState();
}

class _PokelabAppState extends State<PokelabApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> _messengerKey =
  GlobalKey<ScaffoldMessengerState>();
  int _selectedTab = 0;
  final List<int> _teamIds = [6, 25, 133, 1];

  List<Pokemon> get _team =>
      starterPokemon.where((pokemon) => _teamIds.contains(pokemon.id)).toList();

  void _showMessage(String text) {
    _messengerKey.currentState?.showSnackBar(SnackBar(content: Text(text)));
  }

  void _toggleTeam(Pokemon pokemon) {
    setState(() {
      if (_teamIds.contains(pokemon.id)) {
        _teamIds.remove(pokemon.id);
        _showMessage('${pokemon.name} dihapus dari Tim Saya.');
      } else if (_teamIds.length >= 6) {
        _showMessage('Tim sudah penuh. Hapus satu Pokémon terlebih dahulu.');
      } else {
        _teamIds.add(pokemon.id);
        _showMessage('${pokemon.name} ditambahkan ke Tim Saya.');
      }
    });
  }

  void _openPokemon(Pokemon pokemon) {
    _navigatorKey.currentState
        ?.push<void>(
      MaterialPageRoute(
        builder: (_) => PokemonDetailPage(
          pokemon: pokemon,
          isInTeam: _teamIds.contains(pokemon.id),
          onToggle: () => _toggleTeam(pokemon),
        ),
      ),
    )
        .then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(
        team: _team,
        onNavigate: (index) => setState(() => _selectedTab = index),
        onOpen: _openPokemon,
      ),
      PokedexPage(onOpen: _openPokemon),
      TeamPage(
        team: _team,
        onRemove: _toggleTeam,
        onAdd: () => setState(() => _selectedTab = 1),
        onOpen: _openPokemon,
      ),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      scaffoldMessengerKey: _messengerKey,
      title: 'PokéLab',
      theme: buildAppTheme(),
      home: Scaffold(
        body: SafeArea(
          child: IndexedStack(index: _selectedTab, children: pages),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedTab,
          onDestinationSelected: (index) =>
              setState(() => _selectedTab = index),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Beranda',
            ),
            NavigationDestination(
              icon: Icon(Icons.grid_view_outlined),
              selectedIcon: Icon(Icons.grid_view),
              label: 'Pokédex',
            ),
            NavigationDestination(
              icon: Icon(Icons.groups_2_outlined),
              selectedIcon: Icon(Icons.groups_2),
              label: 'Tim Saya',
            ),
          ],
        ),
      ),
    );
  }
}
