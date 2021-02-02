import 'package:pokedex/app/models/pokemon_basic_info.dart';
import 'package:pokedex/app/models/pokemon_detail.dart';

abstract class PokemonRepository {
  Future<List<PokemonBasicInfo>> getPokemons(int limit, int offset);
  Future<PokemonDetail> searchPokemon(String name);
  Future<PokemonDetail> getDetailPokemon(int idPokemon);
}
