import 'package:equatable/equatable.dart';
import 'package:raro_pokedex/core/entites/pokemon.dart';
import 'package:raro_pokedex/modules/home/errors/home_errors.dart';

enum PokemonFavoriteToggleCubitStatus {
  idle,
  loading,
  error,
  done;
}

class PokemonFavoriteToggleCubitState extends Equatable {
  final Pokemon? pokemon;
  final HomeException? error;
  final PokemonFavoriteToggleCubitStatus status;

  const PokemonFavoriteToggleCubitState(
      {this.pokemon, this.error, required this.status});

  factory PokemonFavoriteToggleCubitState.initial() {
    return const PokemonFavoriteToggleCubitState(
        status: PokemonFavoriteToggleCubitStatus.idle);
  }

  PokemonFavoriteToggleCubitState copyWith(
      {Pokemon? pokemon,
      HomeException? error,
      PokemonFavoriteToggleCubitStatus? status}) {
    return PokemonFavoriteToggleCubitState(
      status: status ?? this.status,
      error: error ?? this.error,
      pokemon: pokemon ?? this.pokemon,
    );
  }

  @override
  List<Object?> get props => [pokemon, error, status];
}
