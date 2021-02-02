enum StatusPokemon {
  INITIAL,
  LOADING,
  SUCCESS,
  ERROR,
}

extension StatusPokemonExt on StatusPokemon {
  static String _message;
  String get getMensagem => _message;
  set setMensagem(String value) => _message = value;
}
