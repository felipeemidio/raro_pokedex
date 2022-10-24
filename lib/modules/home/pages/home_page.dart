import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:raro_pokedex/core/entites/pokemon.dart';
import 'package:raro_pokedex/modules/cubit/pokemon_list_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _navigationBarIndex = 0;
  late PageController pageViewController;
  late PokemonsListCubit _pokemonsListCubit;

  @override
  void initState() {
    pageViewController = PageController();
    _pokemonsListCubit = Modular.get<PokemonsListCubit>();
    _pokemonsListCubit.getPokemons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              Modular.to.pushReplacementNamed('/login/');
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: PageView(
        controller: pageViewController,
        children: [
          const Center(child: Text('Favoritos')),
          BlocBuilder<PokemonsListCubit, List<Pokemon>>(
            bloc: _pokemonsListCubit,
            builder: (context, state) {
              return ListView(
                  children: state
                      .map((pokemon) => ListTile(
                            title: Text(
                              pokemon.name,
                            ),
                            leading: Text(pokemon.id),
                          ))
                      .toList());
            },
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _navigationBarIndex,
        onTap: (value) {
          pageViewController.animateToPage(value,
              curve: Curves.easeIn,
              duration: const Duration(milliseconds: 500));
          setState(() {
            _navigationBarIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(label: 'Favorites', icon: Icon(Icons.star)),
          BottomNavigationBarItem(label: 'Pokemons', icon: Icon(Icons.list)),
        ],
      ),
    );
  }
}
