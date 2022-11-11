import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:raro_pokedex/core/drivers/http/client_http.dart';
import 'package:raro_pokedex/core/drivers/local_storage/local_storage.dart';
import 'package:raro_pokedex/core/entites/pokemon.dart';
import 'package:raro_pokedex/modules/home/errors/home_errors.dart';
import 'package:raro_pokedex/modules/home/repositories/pokemons_favorite_repository.dart';

class MockLocalStorage extends Mock implements LocalStorage {}

Pokemon p1 = Pokemon(name: 'Felipe', id: '1');
Pokemon p2 = Pokemon(name: 'Van', id: '2');

void main() {
  final LocalStorage localStorage = MockLocalStorage();
  final favoriteRepository = PokemonsFavoriteRepository(localStorage);
  test('pokemons favorite get repository ...', () async {
    when(() => localStorage.getList(any()))
        .thenAnswer((invocation) async => [p1.toJson(), p2.toJson()]);

    final listPokemon = await favoriteRepository.get();
    expect(listPokemon.length, 2);
    expect(listPokemon[0], p1);
    expect(listPokemon[1], p2);
  });

  test('pokemons favorite get fails', () async {
    when(() => localStorage.getList(any())).thenThrow(Exception());

    expect(() async => await favoriteRepository.get(),
        throwsA(isA<PokemonFavoriteGetException>()));
  });

  test('pokemons favorite remove repository', () async {
    when(() => localStorage.getList(any()))
        .thenAnswer((invocation) async => [p1.toJson(), p2.toJson()]);
    when(() => localStorage.setList(any(), any()))
        .thenAnswer((invocation) async {});

    await favoriteRepository.remove(pokemonsUnfavorite: p2);
    
    verify(() => localStorage.setList(any(), [p1.toJson()])).called(1);
  });
}
