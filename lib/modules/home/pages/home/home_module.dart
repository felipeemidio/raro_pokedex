import 'package:flutter_modular/flutter_modular.dart';
import 'package:raro_pokedex/core/drivers/http/client_http.dart';
import 'package:raro_pokedex/core/drivers/local_storage/local_storage.dart';
import 'package:raro_pokedex/modules/home/cubit/pokemon_favorite_get_cubit.dart';
import 'package:raro_pokedex/modules/home/cubit/pokemon_favorite_toggle_cubit.dart';
import 'package:raro_pokedex/modules/home/cubit/pokemon_list_cubit.dart';
import 'package:raro_pokedex/modules/home/pages/details/pokemon_details_module.dart';
import 'package:raro_pokedex/modules/home/pages/home/home_page.dart';
import 'package:raro_pokedex/modules/home/repositories/pokemons_favorite_repository.dart';
import 'package:raro_pokedex/modules/home/repositories/pokemons_repository.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind(((i) => PokemonRepository(i<ClientHttp>()))),
        Bind(((i) => PokemonsFavoriteRepository(i<LocalStorage>()))),
        Bind(((i) => PokemonsListCubit(i<PokemonRepository>()))),
        Bind(((i) =>
            PokemonFavoriteToggleCubit(i<PokemonsFavoriteRepository>()))),
        Bind(((i) => PokemonFavoriteGetCubit(i<PokemonsFavoriteRepository>()))),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const HomePage()),
        //Ao deixar este módulo aqui, o Home não será fechado quando abrir o Detail
        ModuleRoute('/detailsPokemon', module: DetailsPokemonModule())
      ];
}
