import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raro_pokedex/core/entites/details_pokemon.dart';
import 'package:raro_pokedex/modules/home/cubit/pokemon_detail_cubit_state.dart';
import 'package:raro_pokedex/modules/home/errors/home_errors.dart';
import 'package:raro_pokedex/modules/home/repositories/pokemons_repository.dart';

class PokemonDetailCubit extends Cubit<PokemonDetailCubitState> {
  final PokemonRepository _pokemonRepository;

  PokemonDetailCubit(this._pokemonRepository)
      : super(PokemonDetailCubitState.initial());

  Future<void> getDetails(String pokemonId) async {
    try {
      emit(state.copyWith(status: PokemonDetailCubitStatus.loading));
      final PokemonDetail detailsPokemon =
          await _pokemonRepository.getDetails(pokemonId: pokemonId);

      emit(
        state.copyWith(
            detailsPokemon: detailsPokemon,
            status: PokemonDetailCubitStatus.loaded),
      );
    } on PokemonDetailException catch (e) {
      emit(state.copyWith(error: e, status: PokemonDetailCubitStatus.error));
    }
  }
}
