import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:pokedex/app/models/pokemon_basic_info.dart';
import 'package:pokedex/app/models/pokemon_detail.dart';

part 'pokemon.g.dart';

class Pokemon = _PokemonBase with _$Pokemon;

abstract class _PokemonBase with Store {
  int id;
  Color colorDominant;

  @observable
  bool favorite;

  ImageProvider image;
  PokemonDetail pokemonDetail;

  _PokemonBase(
      {this.id,
      this.colorDominant,
      this.image,
      this.pokemonDetail,
      this.favorite});

  @action
  setFavorite(bool favorite) {
    this.favorite = favorite;
  }
}
