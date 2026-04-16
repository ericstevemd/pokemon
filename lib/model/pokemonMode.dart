class PokemonInfo {
  final String? image;
  final int? id;
  final String? name;
  PokemonInfo({this.image, this.id, this.name});

  factory PokemonInfo.fromJson(Map<String, dynamic> json) {
    return PokemonInfo(
      image: json["sprites"]?["front_default"],
      id: json["id"] as int?,
      name: json["name"] as String?,
    );
  }
}
