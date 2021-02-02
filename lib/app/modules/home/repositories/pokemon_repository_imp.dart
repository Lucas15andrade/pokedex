import 'package:dio/dio.dart';
import 'package:pokedex/app/models/pokemon_basic_info.dart';
import 'package:pokedex/app/models/pokemon_detail.dart';
import 'package:pokedex/app/modules/home/repositories/pokemon_repository.dart';

class PokemonRepositoryImp implements PokemonRepository {
  final Dio _dio;

  PokemonRepositoryImp(this._dio);

  @override
  Future<PokemonDetail> getDetailPokemon(int idPokemon) async {
    try {
      var response = await _dio.get(
        "/pokemon/$idPokemon",
      );

      return PokemonDetail.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PokemonBasicInfo>> getPokemons(int limit, int offset) async {
    try {
      var response = await _dio.get("/pokemon?limit=$limit&offset=$offset");

      return (response.data["results"] as List)
          .map((e) => PokemonBasicInfo.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PokemonDetail> searchPokemon(String name) async {
    try {
      var response = await _dio.get("/pokemon/$name");

      return PokemonDetail.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
