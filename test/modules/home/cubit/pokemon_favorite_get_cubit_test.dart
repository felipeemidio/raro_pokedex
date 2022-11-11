import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:raro_pokedex/core/entites/pokemon.dart';
import 'package:raro_pokedex/modules/home/cubit/pokemon_favorite_get_cubit.dart';
import 'package:raro_pokedex/modules/home/cubit/pokemon_favorite_get_cubit_state.dart';
import 'package:raro_pokedex/modules/home/errors/home_errors.dart';
import 'package:raro_pokedex/modules/home/repositories/pokemons_favorite_repository.dart';

class MockPokemonsFavoriteRepository extends Mock
    implements PokemonsFavoriteRepository {}

Pokemon p1 = Pokemon(name: 'Felipe', id: '1');
Pokemon p2 = Pokemon(name: 'Van', id: '2');
final list = [p1, p2];

void main() {
  final exception = PokemonFavoriteGetException(message: "");

  final pokemonsFavoriteRepository = MockPokemonsFavoriteRepository();
  blocTest(
    'emit loading and loaded when get list successfully',
    build: () {
      when(() => pokemonsFavoriteRepository.get())
          .thenAnswer((invocation) async => list);
      return PokemonFavoriteGetCubit(pokemonsFavoriteRepository);
    },
    act: (cubit) => cubit.getFavoritePokemons(),
    expect: () => [
      const PokemonFavoriteGetCubitState(
          status: PokemonFavoriteGetCubitStatus.loading),
      PokemonFavoriteGetCubitState(
          status: PokemonFavoriteGetCubitStatus.loaded, favoritePokemons: list),
    ],
  );

  blocTest(
    'emit loading and failed when get list fails ',
    build: () {
      when(() => pokemonsFavoriteRepository.get())
          .thenThrow(exception);
      return PokemonFavoriteGetCubit(pokemonsFavoriteRepository);
    },
    act: (cubit) => cubit.getFavoritePokemons(),
    expect: () => [
      const PokemonFavoriteGetCubitState(
          status: PokemonFavoriteGetCubitStatus.loading),
      PokemonFavoriteGetCubitState(
          status: PokemonFavoriteGetCubitStatus.error, error: exception),
    ],
  );
}
