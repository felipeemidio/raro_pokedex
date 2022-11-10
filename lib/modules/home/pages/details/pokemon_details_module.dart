import 'package:flutter_modular/flutter_modular.dart';
import 'package:raro_pokedex/core/drivers/http/client_http.dart';
import 'package:raro_pokedex/modules/home/cubit/pokemon_detail_cubit.dart';
import 'package:raro_pokedex/modules/home/pages/details/pokemon_detail_page.dart';
import 'package:raro_pokedex/modules/home/repositories/pokemons_repository.dart';

class DetailsPokemonModule extends Module {
  @override
  List<Bind> get binds => [
        Bind(((i) => PokemonRepository(i<ClientHttp>()))),
        Bind(((i) => PokemonDetailCubit(i<PokemonRepository>())))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) =>  PokemonDetailPage(pokemon: args.data)),
      ];
}