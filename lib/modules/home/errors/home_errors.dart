class HomeException implements Exception {
  final String message;

  HomeException({required this.message});
}

class PokemonListException extends HomeException {
  PokemonListException({required super.message});
}

class PokemonDetailException extends HomeException {
  PokemonDetailException({required super.message});
}

class PokemonFavoriteGetException extends HomeException {
  PokemonFavoriteGetException({required super.message});
}

class PokemonFavoriteAddException extends HomeException {
  PokemonFavoriteAddException({required super.message});
}

class PokemonFavoriteRemoveException extends HomeException {
  PokemonFavoriteRemoveException({required super.message});
}

class PokemonFavoriteClearException extends HomeException {
  PokemonFavoriteClearException({required super.message});
}

class PokemonFavoriteNotFound extends HomeException {
  PokemonFavoriteNotFound({required super.message});
}
