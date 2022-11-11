import 'package:equatable/equatable.dart';
import 'package:raro_pokedex/modules/home/errors/home_errors.dart';

enum PokemonFavoriteClearCubitStatus {
  idle,
  loading,
  done,
  error,
}

class PokemonFavoriteClearCubitState extends Equatable {
  PokemonFavoriteClearCubitStatus status;
  PokemonFavoriteClearException? error;

  PokemonFavoriteClearCubitState({required this.status, this.error});

  factory PokemonFavoriteClearCubitState.initial() {
    return PokemonFavoriteClearCubitState(
        status: PokemonFavoriteClearCubitStatus.idle);
  }

  PokemonFavoriteClearCubitState copyWith({
    PokemonFavoriteClearCubitStatus? status,
    PokemonFavoriteClearException? error,
  }) {
    return PokemonFavoriteClearCubitState(
        status: status ?? this.status, error: error ?? this.error);
  }

  @override
  List<Object?> get props => [status, error];
}
