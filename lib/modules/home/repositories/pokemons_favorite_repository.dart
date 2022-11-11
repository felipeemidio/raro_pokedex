
import 'package:raro_pokedex/core/drivers/local_storage/local_storage.dart';
import 'package:raro_pokedex/core/entites/pokemon.dart';
import 'package:raro_pokedex/modules/home/errors/home_errors.dart';

/** 
 * Responsabilidades: 
 * Tratar os erros;
 * Converter na entidade;
 * Usar o Driver.
 **/
class PokemonsFavoriteRepository {
  final LocalStorage _localStorage;
  static const String _kPokemonsFavoriteKey = 'pokemons_favorite';

  PokemonsFavoriteRepository(this._localStorage);

  Future<List<Pokemon>> get() async {
    try {
      final result = await _localStorage.getList(_kPokemonsFavoriteKey);
      return result.map((rawPokemon) => Pokemon.fromJson(rawPokemon)).toList();
    } catch (e) {
      throw PokemonFavoriteGetException(
          message: 'Não foi possível obter os pokemons favoritos');
    }
  }

  Future<void> add({required Pokemon favoritePokemon}) async {
    try {
      final List<String> currentListPokemonsFavorite =
          await _localStorage.getList(_kPokemonsFavoriteKey);
      currentListPokemonsFavorite.add(favoritePokemon.toJson());
      await _localStorage.setList(
          _kPokemonsFavoriteKey, currentListPokemonsFavorite);
    } catch (e) {
      throw PokemonFavoriteAddException(
          message: 'Não foi possível adicionar o pokemon aos favoritos');
    }
  }

  Future<void> remove({required Pokemon pokemonsUnfavorite}) async {
    try {
      final favoriteList = await _localStorage.getList(_kPokemonsFavoriteKey);
      final hasItem = favoriteList.remove(pokemonsUnfavorite.toJson());
      if (hasItem) {
        _localStorage.setList(_kPokemonsFavoriteKey, favoriteList);
      } else {
        throw PokemonFavoriteNotFound(message: 'Pokemon não encontrado');
      }
    } catch (e) {
      if (e is PokemonFavoriteNotFound) {
        rethrow;
      }
      throw PokemonFavoriteRemoveException(
          message: 'Não foi possível remover o pokemon dos favoritos');
    }
  }

  Future<void> clear() async {
    try {
      List<String> emptyList = [];
      await _localStorage.setList(_kPokemonsFavoriteKey, emptyList);
    } catch (e) {
      throw PokemonFavoriteClearException(
          message: 'Não ofi possível limpar a lista de favoritos');
    }
  }
}
