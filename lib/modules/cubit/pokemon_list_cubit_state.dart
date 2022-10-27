// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:raro_pokedex/core/entites/pokemon.dart';
import 'package:raro_pokedex/modules/home/errors/home_errors.dart';

enum PokemonsListCubitStatus {
  idle,
  loading,
  error,
  loaded;
}

class PokemonsListCubitState extends Equatable {
  List<Pokemon> pokemons;
  PokemonListException? error;
  PokemonsListCubitStatus status;

  PokemonsListCubitState({
    this.pokemons = const [],
    this.error,
    required this.status,
  });

  factory PokemonsListCubitState.initial() {
    return PokemonsListCubitState(status: PokemonsListCubitStatus.idle);
  }

  PokemonsListCubitState copyWith({
    List<Pokemon>? pokemons,
    PokemonListException? error,
    PokemonsListCubitStatus? status,
  }) {
    return PokemonsListCubitState(
      pokemons: pokemons ?? this.pokemons,
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [pokemons, error, status];
}
