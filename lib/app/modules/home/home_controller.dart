import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:pokedex/app/models/pokemon.dart';
import 'package:pokedex/app/modules/home/services/pokemon_service.dart';
import 'package:pokedex/app/modules/home/status/status_pokemon.dart';

part 'home_controller.g.dart';

@Injectable()
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final PokemonService pokemonService;

  List<Pokemon> pokemons = [];

  int limit = 20;
  int offset = 0;

  @observable
  StatusPokemon loadMore = StatusPokemon.INITIAL;

  @observable
  StatusPokemon statusPokemon = StatusPokemon.INITIAL;

  _HomeControllerBase(this.pokemonService) {
    getAllPokemons();
  }

  Future getAllPokemons() async {
    try {
      statusPokemon = StatusPokemon.LOADING;

      pokemons = await pokemonService.preparePokemons(limit, offset);

      statusPokemon = StatusPokemon.SUCCESS;
    } catch (e) {
      statusPokemon = StatusPokemon.ERROR;
      statusPokemon.setMensagem =
          "Ocorreu um erro. Por favor, tente novamente mais tarde.";
    }
  }

  @action
  Future loadMorePokemons() async {
    try {
      if (loadMore == StatusPokemon.LOADING) {
        return;
      } else {
        loadMore = StatusPokemon.LOADING;
        offset += 20;

        pokemons..addAll(await pokemonService.preparePokemons(limit, offset));

        loadMore = StatusPokemon.SUCCESS;
        statusPokemon = StatusPokemon.SUCCESS;
      }
    } catch (e) {
      statusPokemon = StatusPokemon.ERROR;
      statusPokemon.setMensagem =
          "Ocorreu um erro. Por favor, tente novamente mais tarde.";
    }
  }

  @action
  Future searchPokemon(String name) async {
    try {
      statusPokemon = StatusPokemon.LOADING;

      if (name.isEmpty) {
        pokemons = await pokemonService.preparePokemons(limit, offset);
      } else {
        pokemons = await pokemonService.searchPokemon(name);
      }

      statusPokemon = StatusPokemon.SUCCESS;
    } catch (e) {
      statusPokemon = StatusPokemon.ERROR;
      statusPokemon.setMensagem =
          "Ocorreu um erro. Por favor, tente novamente mais tarde.";
    }
  }

  setPokemonFavorite(bool isFavorite, int id) async {
    Pokemon pokemon = pokemons.firstWhere((poke) => poke.id == id);
    int index = pokemons.indexOf(pokemon);

    pokemon.setFavorite(isFavorite);
    pokemons[index] = pokemon;

    await pokemonService.favoritePokemon(pokemon);
  }

  orderByFavorites() {
    pokemons.sort((a, b) {
      if (b.favorite) {
        return 1;
      } else {
        return -1;
      }
    });

    statusPokemon = StatusPokemon.SUCCESS;
  }
}
