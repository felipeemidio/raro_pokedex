import 'package:flutter_modular/flutter_modular.dart';
import 'package:raro_pokedex/modules/cubit/pokemon_list_cubit.dart';
import 'package:raro_pokedex/modules/home/pages/home_page.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
    Bind(((i) => PokemonsListCubit()))
  ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const HomePage()),
      ];
}
