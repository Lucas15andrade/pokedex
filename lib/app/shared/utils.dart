class Utils {
  static int getIdPokemonFromUrl(String url) {
    return int.parse(url
        .replaceAll("https://pokeapi.co/api/v2/pokemon/", "")
        .replaceAll("/", ""));
  }
}
