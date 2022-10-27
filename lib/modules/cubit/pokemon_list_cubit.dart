import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raro_pokedex/modules/cubit/pokemon_list_cubit_state.dart';
import 'package:raro_pokedex/modules/home/errors/home_errors.dart';
import 'package:raro_pokedex/modules/home/repositories/pokemons_repository.dart';

class PokemonsListCubit extends Cubit<PokemonsListCubitState> {
  final PokemonRepository _pokemonRepository;
  PokemonsListCubit(this._pokemonRepository)
      : super(PokemonsListCubitState.initial());

  Future<void> getPokemons() async {
    try {
      emit(state.copyWith(status: PokemonsListCubitStatus.loading));
      final pokemons = await _pokemonRepository.getPokemons();
      emit(state.copyWith(
          pokemons: pokemons, status: PokemonsListCubitStatus.loaded));
    } on PokemonListException catch (e) {
      emit(state.copyWith(error: e, status: PokemonsListCubitStatus.error));
    }
  }
}
