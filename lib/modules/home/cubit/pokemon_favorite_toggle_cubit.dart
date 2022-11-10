import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raro_pokedex/core/entites/pokemon.dart';
import 'package:raro_pokedex/modules/home/cubit/pokemon_favorite_toggle_cubit_state.dart';
import 'package:raro_pokedex/modules/home/errors/home_errors.dart';
import 'package:raro_pokedex/modules/home/repositories/pokemons_favorite_repository.dart';

class PokemonFavoriteToggleCubit extends Cubit<PokemonFavoriteToggleCubitState> {
  final PokemonsFavoriteRepository _pokemonFavoriteRepository;

  PokemonFavoriteToggleCubit(this._pokemonFavoriteRepository)
      : super(PokemonFavoriteToggleCubitState.initial());

  Future<void> toggleFavoritePokemon(Pokemon favoritePokemon) async {
    try {
      emit(state.copyWith(status: PokemonFavoriteToggleCubitStatus.loading));
      final favoritePokemons = await _pokemonFavoriteRepository.get();

      if (favoritePokemons.contains(favoritePokemon)) {
        await _pokemonFavoriteRepository.remove(
            pokemonsUnfavorite: favoritePokemon);
      } else {
        await _pokemonFavoriteRepository.add(favoritePokemon: favoritePokemon);
      }

      emit(state.copyWith(status: PokemonFavoriteToggleCubitStatus.done));
    } on HomeException catch (e) {
      emit(state.copyWith(
          error: e, status: PokemonFavoriteToggleCubitStatus.error));
    }
  }
}
