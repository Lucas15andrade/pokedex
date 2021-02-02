import 'package:flutter/cupertino.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pokedex/app/models/pokemon.dart';
import 'package:pokedex/app/models/pokemon_basic_info.dart';
import 'package:pokedex/app/models/pokemon_detail.dart';
import 'package:pokedex/app/modules/home/repositories/pokemon_repository.dart';
import 'package:pokedex/app/shared/shared_preferences_utils.dart';
import 'package:pokedex/app/shared/utils.dart';

class PokemonService {
  final PokemonRepository pokemonRepository;

  PokemonService(this.pokemonRepository);

  Future<List<Pokemon>> preparePokemons(int limit, int offset) async {
    List<PokemonBasicInfo> pokemonsBasicInfo =
        await pokemonRepository.getPokemons(limit, offset);

    return await getPokemonWithCharacteristics(pokemonsBasicInfo);
  }

  Future<List<Pokemon>> searchPokemon(String name) async {
    List<int> idsFavoritePokemons = await getFavoritePokemons();

    PokemonDetail pokemonDetail = await pokemonRepository.searchPokemon(name);
    int idPokemon = pokemonDetail.id;

    ImageProvider image = await getImagePokemon(idPokemon);
    Color colorDominant = await getColorDominantPokemon(image);

    bool isFavorite =
        idsFavoritePokemons.any((element) => element == idPokemon);

    Pokemon pokemon = Pokemon(
        id: idPokemon,
        pokemonDetail: pokemonDetail,
        image: image,
        colorDominant: colorDominant,
        favorite: isFavorite);

    return List.of([pokemon]);
  }

  Future<ImageProvider> getImagePokemon(int id) async {
    return Image.network(
            "https://pokeres.bastionbot.org/images/pokemon/$id.png")
        .image;
  }

  Future<Color> getColorDominantPokemon(ImageProvider image) async {
    var paletteGenerator = await PaletteGenerator.fromImageProvider(image);
    return paletteGenerator.dominantColor.color;
  }

  Future<PokemonDetail> getDetailPokemon(int id) async {
    return await pokemonRepository.getDetailPokemon(id);
  }

  Future<List<Pokemon>> getPokemonWithCharacteristics(
      List<PokemonBasicInfo> pokemonsBasicInfo) async {
    List<Pokemon> pokemonsFormed = [];
    List<int> idsFavoritePokemons = await getFavoritePokemons();

    for (PokemonBasicInfo pokemonBasicInfo in pokemonsBasicInfo) {
      int idPokemon = Utils.getIdPokemonFromUrl(pokemonBasicInfo.url);

      ImageProvider image = await getImagePokemon(idPokemon);
      Color colorDominant = await getColorDominantPokemon(image);
      PokemonDetail pokemonDetail = await getDetailPokemon(idPokemon);

      bool isFavorite =
          idsFavoritePokemons.any((element) => element == idPokemon);

      Pokemon pokemon = Pokemon(
          id: idPokemon,
          pokemonDetail: pokemonDetail,
          image: image,
          colorDominant: colorDominant,
          favorite: isFavorite);

      pokemonsFormed.add(pokemon);
    }

    return pokemonsFormed;
  }

  Future favoritePokemon(Pokemon pokemon) async {
    List<int> idsFavoritePokemons = await getFavoritePokemons();

    if (pokemon.favorite) {
      idsFavoritePokemons.add(pokemon.id);
    } else {
      idsFavoritePokemons.removeWhere((element) => element == pokemon.id);
    }

    await SharedPreferencesUtils.save("favorite_pokemons", idsFavoritePokemons);
  }

  Future<List<int>> getFavoritePokemons() async {
    var favoritePokemons =
        await SharedPreferencesUtils.read("favorite_pokemons") ?? [];

    return List<int>.from(favoritePokemons);
  }
}
