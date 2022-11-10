// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:raro_pokedex/core/entites/details_pokemon.dart';
import 'package:raro_pokedex/modules/home/cubit/pokemon_list_cubit_state.dart';
import 'package:raro_pokedex/modules/home/errors/home_errors.dart';

enum PokemonDetailCubitStatus {
  idle,
  loading,
  error,
  loaded;
}

class PokemonDetailCubitState extends Equatable {
  final PokemonDetail? detailsPokemon;
  final PokemonDetailException? error;
  final PokemonDetailCubitStatus status;

  const PokemonDetailCubitState({
    this.detailsPokemon,
    this.error,
    required this.status,
  });

  factory PokemonDetailCubitState.initial() {
    return const PokemonDetailCubitState(status: PokemonDetailCubitStatus.idle);
  }

  PokemonDetailCubitState copyWith(
      {PokemonDetail? detailsPokemon,
      PokemonDetailException? error,
      PokemonDetailCubitStatus? status}) {
    return PokemonDetailCubitState(
      status: status ?? this.status,
      error: error ?? this.error,
      detailsPokemon: detailsPokemon ?? this.detailsPokemon,
    );
  }

  @override
  List<Object?> get props => [status, detailsPokemon, error];
}
