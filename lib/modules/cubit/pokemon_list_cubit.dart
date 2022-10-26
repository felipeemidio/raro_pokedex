import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raro_pokedex/core/entites/pokemon.dart';
import 'package:raro_pokedex/modules/home/repositories/pokemons_repository.dart';

class PokemonsListCubit extends Cubit<List<Pokemon>> {
  final PokemonRepository _pokemonRepository;
  PokemonsListCubit(this._pokemonRepository) : super([]);

  Future<void> getPokemons() async {
    final pokemons = await _pokemonRepository.getPokemons();
    emit(pokemons);
  }
}
