// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $HomeController = BindInject(
  (i) => HomeController(i<PokemonService>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$loadMoreAtom = Atom(name: '_HomeControllerBase.loadMore');

  @override
  StatusPokemon get loadMore {
    _$loadMoreAtom.reportRead();
    return super.loadMore;
  }

  @override
  set loadMore(StatusPokemon value) {
    _$loadMoreAtom.reportWrite(value, super.loadMore, () {
      super.loadMore = value;
    });
  }

  final _$statusPokemonAtom = Atom(name: '_HomeControllerBase.statusPokemon');

  @override
  StatusPokemon get statusPokemon {
    _$statusPokemonAtom.reportRead();
    return super.statusPokemon;
  }

  @override
  set statusPokemon(StatusPokemon value) {
    _$statusPokemonAtom.reportWrite(value, super.statusPokemon, () {
      super.statusPokemon = value;
    });
  }

  final _$loadMorePokemonsAsyncAction =
      AsyncAction('_HomeControllerBase.loadMorePokemons');

  @override
  Future<dynamic> loadMorePokemons() {
    return _$loadMorePokemonsAsyncAction.run(() => super.loadMorePokemons());
  }

  final _$searchPokemonAsyncAction =
      AsyncAction('_HomeControllerBase.searchPokemon');

  @override
  Future<dynamic> searchPokemon(String name) {
    return _$searchPokemonAsyncAction.run(() => super.searchPokemon(name));
  }

  @override
  String toString() {
    return '''
loadMore: ${loadMore},
statusPokemon: ${statusPokemon}
    ''';
  }
}
