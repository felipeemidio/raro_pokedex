import 'package:flutter_test/flutter_test.dart';
import 'package:raro_pokedex/core/entites/http_response.dart';
import 'package:raro_pokedex/core/http/client_http.dart';
import 'package:raro_pokedex/modules/home/repositories/pokemons_repository.dart';

class FakeClientHttp implements ClientHttp {
  @override
  Future<HttpResponse> get(
      {required String url, Map<String, dynamic>? params}) async {
    return HttpResponse(
      data: {
        "results": [
          {"name": "Pikachu", "url": "https://pokeapi.co/api/v2/pokemon/1/"}
        ]
      },
      message: "",
      statusCode: 200,
    );
  }
}

void main() {
  test('Pokemons list is not Empty', () async {
    final ClientHttp clientHttp = FakeClientHttp();
    final PokemonRepository pokemonRepository = PokemonRepository(clientHttp);

    final pokemons = await pokemonRepository.getPokemons();

    expect(pokemons.isEmpty, false);
  });
}
