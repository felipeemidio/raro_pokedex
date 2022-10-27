import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:raro_pokedex/modules/cubit/pokemon_list_cubit.dart';
import 'package:raro_pokedex/modules/cubit/pokemon_list_cubit_state.dart';

class PokemonListView extends StatefulWidget {
  const PokemonListView({super.key});

  @override
  State<PokemonListView> createState() => _PokemonListViewState();
}

class _PokemonListViewState extends State<PokemonListView> {
  late PokemonsListCubit _pokemonsListCubit;

  @override
  void initState() {
    _pokemonsListCubit = Modular.get<PokemonsListCubit>();
    _pokemonsListCubit.getPokemons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PokemonsListCubit, PokemonsListCubitState>(
      listener: (context, state) {
        if (state.status == PokemonsListCubitStatus.error) {
          final snackBar = SnackBar(
            backgroundColor: Colors.red,
            content: Text(state.error!.message),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      bloc: _pokemonsListCubit,
      builder: (context, state) {
        return ListView(
            children: state.pokemons
                .map((pokemon) => ListTile(
                      title: Text(
                        pokemon.name,
                      ),
                      leading: Text(pokemon.id),
                    ))
                .toList());
      },
    );
  }
}
