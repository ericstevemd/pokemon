import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pokemon/env/dio_client.dart';
import 'package:pokemon/schema/pokemon.dart';
import 'package:pokemon/server/pokemonService.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final dio = DioClient.instance;

  final pokemonService = PokemonService(dio: dio);
  runApp(MyApp(pokemonService: pokemonService));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.pokemonService});

  final PokemonService pokemonService;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Pokemon(pokemonService: pokemonService),
    );
  }
}
