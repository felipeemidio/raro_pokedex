import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raro_pokedex/modules/home/cubit/pokemon_favorite_get_cubit_state.dart';
import 'package:raro_pokedex/modules/home/errors/home_errors.dart';
import 'package:raro_pokedex/modules/home/repositories/pokemons_favorite_repository.dart';

class PokemonFavoriteGetCubit extends Cubit<PokemonFavoriteGetCubitState> {
  final PokemonsFavoriteRepository _pokemonsFavoriteRepository;

  PokemonFavoriteGetCubit(this._pokemonsFavoriteRepository)
      : super(PokemonFavoriteGetCubitState.initial());

  Future<void> getFavoritePokemons() async {
    try {
      emit(state.copyWith(status: PokemonFavoriteGetCubitStatus.loading));
      final currentList = await _pokemonsFavoriteRepository.get();
      print("CurrentList: $currentList ");
      emit(state.copyWith(
          status: PokemonFavoriteGetCubitStatus.loaded,
          favoritePokemons: currentList));
    } on PokemonFavoriteGetException catch (e) {
      emit(state.copyWith(
          error: e, status: PokemonFavoriteGetCubitStatus.error));
    }
  }
}
