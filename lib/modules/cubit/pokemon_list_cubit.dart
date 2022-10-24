import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raro_pokedex/core/entites/pokemon.dart';

class PokemonsListCubit extends Cubit<List<Pokemon>> {
  PokemonsListCubit({List<Pokemon> initialState = const []}) : super(initialState);

  void getPokemons() => emit([
        Pokemon(name: 'Charmander', id: '1'),
        Pokemon(name: 'Pikachu', id: '2')
      ]);
}
