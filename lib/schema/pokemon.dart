import 'package:flutter/material.dart';
import 'package:pokemon/model/pokemonMode.dart';
import 'package:pokemon/server/pokemonService.dart';

class Pokemon extends StatefulWidget {
  final PokemonService pokemonService;
  const Pokemon({super.key, required this.pokemonService});

  @override
  State<Pokemon> createState() => _PokemonState();
}

class _PokemonState extends State<Pokemon> {
  PokemonInfo? _pokemon;

  @override
  void initState() {
    super.initState();
    _fetchPokemon(1);
  }

  Future<void> _fetchPokemon(int id) async {
    try {
      final pokedex = await widget.pokemonService.getPokemon(id);
      setState(() => _pokemon = pokedex);
    } catch (e) {
      print('Error al obtener el Pokémon: $e');
      setState(() => _pokemon = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("pokedex")),
      body: Column(
        children: [
          namePokede(pokemon: _pokemon),
          FloatingActionButton(
            onPressed: _pokemon != null
                ? () => _fetchPokemon(_pokemon!.id! + 1)
                : null,
            child: const Icon(Icons.add),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              if (_pokemon != null && _pokemon!.id! > 1) {
                _fetchPokemon(_pokemon!.id! - 1);
              }
            },
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}

class namePokede extends StatelessWidget {
  const namePokede({super.key, required PokemonInfo? pokemon})
    : _pokemon = pokemon;

  final PokemonInfo? _pokemon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Center(
            child: _pokemon == null
                ? const Text('Pokémon no encontrado')
                : Text(
                    _pokemon!.name ?? '',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
          Image.network(
            _pokemon?.image ??
                'https://ichef.bbci.co.uk/ace/ws/640/cpsprodpb/9D48/production/_126546204_gettyimages-1193951547.jpg.webp',
            height: 120,
            width: 120,
          ),
        ],
      ),
    );
  }
}
