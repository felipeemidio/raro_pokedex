class HomeException implements Exception {
  final String message;

  HomeException({required this.message});
}

class PokemonListException extends HomeException {
  PokemonListException({required super.message});
}
