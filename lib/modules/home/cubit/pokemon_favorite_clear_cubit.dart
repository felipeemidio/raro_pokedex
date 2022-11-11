import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raro_pokedex/modules/home/cubit/pokemon_favorite_clear_cubit_state.dart';
import 'package:raro_pokedex/modules/home/errors/home_errors.dart';
import 'package:raro_pokedex/modules/home/repositories/pokemons_favorite_repository.dart';

class PokemonFavoriteClearCubit extends Cubit<PokemonFavoriteClearCubitState> {
  final PokemonsFavoriteRepository _pokemonsFavoriteRepository;

  PokemonFavoriteClearCubit(this._pokemonsFavoriteRepository)
      : super(PokemonFavoriteClearCubitState.initial());

  Future<void> clearFavoritePokemons() async {
    try {
      emit(state.copyWith(status: PokemonFavoriteClearCubitStatus.loading));
      await _pokemonsFavoriteRepository.clear();

      emit(state.copyWith(
        status: PokemonFavoriteClearCubitStatus.done,
      ));
    } on PokemonFavoriteClearException catch (e) {
      emit(state.copyWith(
          error: e, status: PokemonFavoriteClearCubitStatus.error));
    }
  }
}
