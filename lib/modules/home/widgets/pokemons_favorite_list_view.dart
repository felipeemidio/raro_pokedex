import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:raro_pokedex/modules/home/cubit/pokemon_favorite_clear_cubit.dart';
import 'package:raro_pokedex/modules/home/cubit/pokemon_favorite_get_cubit.dart';
import 'package:raro_pokedex/modules/home/cubit/pokemon_favorite_get_cubit_state.dart';

class PokemonFavoriteListView extends StatefulWidget {
  const PokemonFavoriteListView({super.key});

  @override
  State<PokemonFavoriteListView> createState() =>
      _PokemonFavoriteListViewState();
}

class _PokemonFavoriteListViewState extends State<PokemonFavoriteListView> {
  late PokemonFavoriteGetCubit _pokemonFavoriteGetCubit;
  late PokemonFavoriteClearCubit _pokemonFavoriteClearCubit;

  @override
  void initState() {
    _pokemonFavoriteGetCubit = Modular.get<PokemonFavoriteGetCubit>();
    _pokemonFavoriteClearCubit = Modular.get<PokemonFavoriteClearCubit>();
    _pokemonFavoriteGetCubit.getFavoritePokemons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PokemonFavoriteGetCubit, PokemonFavoriteGetCubitState>(
      bloc: _pokemonFavoriteGetCubit,
      listener: (context, state) {
        if (state.status == PokemonFavoriteGetCubitStatus.error) {
          final snackBar = SnackBar(
            backgroundColor: Colors.red,
            content: Text(state.error!.message),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        int listSize = state.favoritePokemons?.length ?? 0;
        if (listSize > 0) {
          listSize += 1;
        } else if (listSize == 0) {
          return const Center(child: Text('A lista está vazia'));
        }
        return ListView.builder(
          itemCount: listSize,
          itemBuilder: (context, index) {
            if (index == listSize - 1) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                child: ElevatedButton(
                    onPressed: () {
                      _pokemonFavoriteClearCubit.clearFavoritePokemons();
                      _pokemonFavoriteGetCubit.getFavoritePokemons();
                    },
                    child: const Text('CLEAR')),
              );
            }
            final currentPokemon = state.favoritePokemons![index];
            return ListTile(
              title: Text(currentPokemon.name),
              leading: Text(currentPokemon.id),
            );
          },
        );
      },
    );
  }
}
