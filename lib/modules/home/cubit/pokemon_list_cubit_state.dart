// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:raro_pokedex/core/entites/pagination.dart';
import 'package:raro_pokedex/core/entites/pokemon.dart';
import 'package:raro_pokedex/modules/home/errors/home_errors.dart';

enum PokemonsListCubitStatus {
  idle,
  loading,
  error,
  loaded;
}

class PokemonsListCubitState extends Equatable {
  Pagination<Pokemon>? pokemonsPagination;
  PokemonListException? error;
  PokemonsListCubitStatus status;

  PokemonsListCubitState({
    this.pokemonsPagination,
    this.error,
    required this.status,
  });

  factory PokemonsListCubitState.initial() {
    return PokemonsListCubitState(status: PokemonsListCubitStatus.idle);
  }

  PokemonsListCubitState copyWith({
    Pagination<Pokemon>? pokemonsPagination,
    PokemonListException? error,
    PokemonsListCubitStatus? status,
  }) {
    return PokemonsListCubitState(
      pokemonsPagination: pokemonsPagination ?? this.pokemonsPagination,
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [pokemonsPagination, error, status];
}
