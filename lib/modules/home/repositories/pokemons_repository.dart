import 'package:raro_pokedex/core/entites/details_pokemon.dart';
import 'package:raro_pokedex/core/entites/pagination.dart';
import 'package:raro_pokedex/core/entites/pokemon.dart';
import 'package:raro_pokedex/core/drivers/http/client_http.dart';
import 'package:raro_pokedex/modules/home/errors/home_errors.dart';

class PokemonRepository {
  final ClientHttp _client;

  PokemonRepository(this._client);

  Future<Pagination<Pokemon>> getPokemons({int size = 20, int page = 0}) async {
    final int offset = size * page;

    try {
      final response = await _client.get(
        url: "https://pokeapi.co/api/v2/pokemon",
        params: {"offset": offset, "limit": size},
      );
      final result = response.data['results'] as List;
      final pagination = Pagination<Pokemon>(
        content: result.map((e) => Pokemon.fromMap(e)).toList(),
        quantity: response.data['count'] ?? 0,
        hasNextPage: response.data['next'] != null,
        hasPreviousPage: response.data['previous'] != null,
      );
      return pagination;
    } catch (e) {
      throw PokemonListException(
          message: "Não foi possível obter a listagem de pokemons");
    }
  }

  Future<PokemonDetail> getDetails({required String pokemonId}) async {
    try {
      final response = await _client.get(
          url: "https://pokeapi.co/api/v2/pokemon/$pokemonId");
      final types = response.data['types'] as List;
      final details = PokemonDetail(
        image: response.data['sprites']['other']['dream_world']
                ['front_default'] ??
            "",
        types: types.map((e) => e['type']['name'] as String).toList(),
      );
      return details;
    } catch (e) {
      throw PokemonDetailException(
          message: "Não foi possível obter os detalhes do pokemons");
    }
  }
}
