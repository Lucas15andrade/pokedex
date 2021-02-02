// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Pokemon on _PokemonBase, Store {
  final _$favoriteAtom = Atom(name: '_PokemonBase.favorite');

  @override
  bool get favorite {
    _$favoriteAtom.reportRead();
    return super.favorite;
  }

  @override
  set favorite(bool value) {
    _$favoriteAtom.reportWrite(value, super.favorite, () {
      super.favorite = value;
    });
  }

  final _$_PokemonBaseActionController = ActionController(name: '_PokemonBase');

  @override
  dynamic setFavorite(bool favorite) {
    final _$actionInfo = _$_PokemonBaseActionController.startAction(
        name: '_PokemonBase.setFavorite');
    try {
      return super.setFavorite(favorite);
    } finally {
      _$_PokemonBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
favorite: ${favorite}
    ''';
  }
}
