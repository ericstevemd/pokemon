import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get baseUrl =>
      dotenv.env['API_HOT_POKEMON'] ?? 'https://pokeapi.co/api/v2/';

  static int get connectTimeout =>
      int.tryParse(dotenv.env['CONNECT_TIMEOUT'] ?? '5') ?? 5;

  static int get receivestimeout =>
      int.tryParse(dotenv.env['RECEIVE_TIMEOUT'] ?? '3') ?? 3;
}
