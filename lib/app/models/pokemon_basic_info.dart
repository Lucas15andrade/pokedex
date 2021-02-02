class PokemonBasicInfo {
  String name;
  String url;

  PokemonBasicInfo({this.name, this.url});

  PokemonBasicInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}
