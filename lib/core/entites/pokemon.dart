class Pokemon {
  final String name;
  final String id;

  Pokemon({required this.name, required this.id});

  factory Pokemon.fromMap(Map map) {
    final splittedUrl = map['url'].split("/");

    return Pokemon(name: map['name'], id: splittedUrl[splittedUrl.length - 2]);
  }
}
