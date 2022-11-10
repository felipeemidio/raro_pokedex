import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raro_pokedex/core/entites/pokemon.dart';
import 'package:raro_pokedex/modules/home/cubit/pokemon_list_cubit_state.dart';
import 'package:raro_pokedex/modules/home/errors/home_errors.dart';
import 'package:raro_pokedex/modules/home/repositories/pokemons_repository.dart';

class PokemonsListCubit extends Cubit<PokemonsListCubitState> {
  final PokemonRepository _pokemonRepository;
  int page = 0;
  final int size = 20;

  PokemonsListCubit(this._pokemonRepository)
      : super(PokemonsListCubitState.initial());

  Future<void> getPokemons() async {
    if (state.status == PokemonsListCubitStatus.loading) {
      return;
    }
    try {
      emit(state.copyWith(status: PokemonsListCubitStatus.loading));
      final List<Pokemon> currentPokemons =
          state.pokemonsPagination?.content ?? [];
      final pokemonsPagination =
          await _pokemonRepository.getPokemons(page: page, size: size);
      if (pokemonsPagination.hasNextPage) {
        page += 1;
      }

      emit(state.copyWith(
        pokemonsPagination: pokemonsPagination.copyWith(
            content: [...currentPokemons, ...pokemonsPagination.content]),
        status: PokemonsListCubitStatus.loaded,
      ));
    } on PokemonListException catch (e) {
      emit(state.copyWith(error: e, status: PokemonsListCubitStatus.error));
    }
  }
}
