import 'package:flutter_modular/flutter_modular.dart';
import 'package:raro_pokedex/core/http/client_http.dart';
import 'package:raro_pokedex/modules/cubit/pokemon_list_cubit.dart';
import 'package:raro_pokedex/modules/home/pages/home_page.dart';
import 'package:raro_pokedex/modules/home/repositories/pokemons_repository.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind(((i) => PokemonRepository(i<ClientHttp>()))),
        Bind(((i) => PokemonsListCubit(i<PokemonRepository>()))),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const HomePage()),
      ];
}
