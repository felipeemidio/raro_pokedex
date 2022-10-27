import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:raro_pokedex/core/entites/http_response.dart';
import 'package:raro_pokedex/core/http/client_http.dart';
import 'package:raro_pokedex/modules/home/errors/home_errors.dart';
import 'package:raro_pokedex/modules/home/repositories/pokemons_repository.dart';

class MockClientHttp extends Mock implements ClientHttp {}

void main() {
  test('Pokemons list is not Empty', () async {
    final ClientHttp clientHttp = MockClientHttp();
    when(() => clientHttp.get(url: any(named: "url")))
        .thenAnswer((realInvocation) async => HttpResponse(
              data: {
                "results": [
                  {
                    "name": "Pikachu",
                    "url": "https://pokeapi.co/api/v2/pokemon/1/"
                  }
                ]
              },
              message: "",
              statusCode: 200,
            ));
    final PokemonRepository pokemonRepository = PokemonRepository(clientHttp);

    final pokemons = await pokemonRepository.getPokemons();

    expect(pokemons.isEmpty, false);
  });

  test('Pokemons list fails', () async {
    final ClientHttp clientHttp = MockClientHttp();
    final PokemonRepository pokemonRepository = PokemonRepository(clientHttp);

    when(() => clientHttp.get(url: any(named: "url"))).thenThrow(Exception());

    expect(() async => await pokemonRepository.getPokemons(),
        throwsA(isA<PokemonListException>()));
  });
}
