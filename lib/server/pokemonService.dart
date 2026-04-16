import 'package:dio/dio.dart';
import 'package:pokemon/env/dio_client.dart';
import 'package:pokemon/model/pokemonMode.dart';

class PokemonService {
  final Dio dio;

  // ✅ 3. Constructor con parámetro nombrado 'dio'
  PokemonService({required this.dio});
  Future<PokemonInfo> getPokemon(int id) async {
    try {
      final response = await DioClient.instance.get('pokemon/$id');
      return PokemonInfo.fromJson(response.data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        throw Exception('Pokémon no encontrado (404)');
      }
      throw Exception('Error de conexión: ${e.message}');
    } catch (e) {
      throw Exception('Error inesperado: $e');
    }
  }
}
