import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Pokemon extends Equatable {
  final String name;
  final String id;
  bool favorite;

  Pokemon({required this.name, required this.id, this.favorite = false});

  factory Pokemon.fromMap(Map map) {
    final splittedUrl = map['url'].split("/");

    return Pokemon(name: map['name'], id: splittedUrl[splittedUrl.length - 2]);
  }

  factory Pokemon.fromJson(String rawPokemon) {
    final pokemonMap = jsonDecode(rawPokemon);
    return Pokemon(
      name: pokemonMap['name'],
      id: pokemonMap['id'],
    );
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
    };
  }

  @override
  String toString() {
    return toJson();
  }
  
  @override
  List<Object?> get props => [id, name];
}
