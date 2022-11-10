import 'package:equatable/equatable.dart';
import 'package:raro_pokedex/core/entites/pokemon.dart';
import 'package:raro_pokedex/modules/home/errors/home_errors.dart';

enum PokemonFavoriteGetCubitStatus {
  idle,
  loading,
  loaded,
  error,
}

class PokemonFavoriteGetCubitState extends Equatable {
  final List<Pokemon>? favoritePokemons;
  final PokemonFavoriteGetException? error;
  final PokemonFavoriteGetCubitStatus status;

  const PokemonFavoriteGetCubitState(
      {this.favoritePokemons, this.error, required this.status});

  factory PokemonFavoriteGetCubitState.initial() {
    return const PokemonFavoriteGetCubitState(
        status: PokemonFavoriteGetCubitStatus.idle);
  }

  PokemonFavoriteGetCubitState copyWith(
      {List<Pokemon>? favoritePokemons,
      PokemonFavoriteGetException? error,
      PokemonFavoriteGetCubitStatus? status}) {
    return PokemonFavoriteGetCubitState(
        status: status ?? this.status,
        error: error ?? this.error,
        favoritePokemons: favoritePokemons ?? this.favoritePokemons);
  }

  @override
  List<Object?> get props => [status, error, favoritePokemons];
}
