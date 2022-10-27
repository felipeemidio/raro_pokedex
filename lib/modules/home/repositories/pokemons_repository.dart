import 'package:raro_pokedex/core/entites/pokemon.dart';
import 'package:raro_pokedex/core/http/client_http.dart';
import 'package:raro_pokedex/modules/home/errors/home_errors.dart';

class PokemonRepository {
  final ClientHttp _client;

  PokemonRepository(this._client);

  Future<List<Pokemon>> getPokemons() async {
    try {
      final response =
          await _client.get(url: "https://pokeapi.co/api/v2/pokemon/");
      final result = response.data['results'] as List;
      return result.map((e) => Pokemon.fromMap(e)).toList();
    } catch (e) {
      throw PokemonListException(
          message: "Não foi possível obter a listagem de pokemons");
    }
  }
}
