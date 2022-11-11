import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:raro_pokedex/core/entites/pokemon.dart';
import 'package:raro_pokedex/modules/home/cubit/pokemon_favorite_get_cubit.dart';
import 'package:raro_pokedex/modules/home/cubit/pokemon_favorite_get_cubit_state.dart';
import 'package:raro_pokedex/modules/home/cubit/pokemon_favorite_toggle_cubit.dart';
import 'package:raro_pokedex/modules/home/cubit/pokemon_favorite_toggle_cubit_state.dart';
import 'package:raro_pokedex/modules/home/cubit/pokemon_list_cubit.dart';
import 'package:raro_pokedex/modules/home/cubit/pokemon_list_cubit_state.dart';

class PokemonListView extends StatefulWidget {
  const PokemonListView({super.key});

  @override
  State<PokemonListView> createState() => _PokemonListViewState();
}

class _PokemonListViewState extends State<PokemonListView> {
  late PokemonsListCubit _pokemonsListCubit;
  late PokemonFavoriteToggleCubit _pokemonFavoriteToggleCubit;
  late PokemonFavoriteGetCubit _pokemonFavoriteGetCubit;
  bool favorite = false;

  @override
  void initState() {
    _pokemonsListCubit = Modular.get<PokemonsListCubit>();
    _pokemonFavoriteToggleCubit = Modular.get<PokemonFavoriteToggleCubit>();
    _pokemonFavoriteGetCubit = Modular.get<PokemonFavoriteGetCubit>();
    _pokemonsListCubit.getPokemons();
    _pokemonFavoriteGetCubit.getFavoritePokemons();
    super.initState();
  }

  Widget _buildListItem(Pokemon pokemon) {
    return ListTile(
      onTap: () {
        Modular.to.pushNamed('/home/detailsPokemon/', arguments: pokemon);
      },
      title: Text(pokemon.name),
      leading: Text(pokemon.id),
      trailing: IconButton(
        onPressed: () {
          _pokemonFavoriteToggleCubit.toggleFavoritePokemon(pokemon);
        },
        icon: pokemon.favorite
            ? const Icon(Icons.favorite)
            : const Icon(Icons.favorite_border),
      ),
    );
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
      builder: (context, favoriteState) {
        return BlocListener<PokemonFavoriteToggleCubit,
            PokemonFavoriteToggleCubitState>(
          bloc: _pokemonFavoriteToggleCubit,
          listener: (context, state) {
            if (state.status == PokemonFavoriteToggleCubitStatus.error) {
              final snackBar = SnackBar(
                backgroundColor: Colors.red,
                content: Text(state.error!.message),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else if (state.status == PokemonFavoriteToggleCubitStatus.done) {
              _pokemonFavoriteGetCubit.getFavoritePokemons();
            }
          },
          child: BlocConsumer<PokemonsListCubit, PokemonsListCubitState>(
            bloc: _pokemonsListCubit,
            listener: (context, state) {
              if (state.status == PokemonsListCubitStatus.error) {
                final snackBar = SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(state.error!.message),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            builder: (context, state) {
              List<Pokemon> pokemons = state.pokemonsPagination?.content ?? [];
              final favoritePokemons = favoriteState.favoritePokemons ?? [];
              pokemons = pokemons.map((currentPokemon) {
                currentPokemon.favorite = favoritePokemons.contains(currentPokemon);
                return currentPokemon;
              }).toList();

              bool hasNextPage = state.pokemonsPagination?.hasNextPage ?? false;
              int listSize = state.pokemonsPagination?.content.length ?? 0;
              if (hasNextPage) {
                listSize += 1;
              }

              return ListView.builder(
                itemCount: listSize,
                itemBuilder: (context, index) {
                  if (index == listSize - 1) {
                    _pokemonsListCubit.getPokemons();
                    return const SizedBox(
                      height: 80,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  final pokemons = state.pokemonsPagination!.content;
                  return _buildListItem(pokemons[index]);
                },
              );
            },
          ),
        );
      },
    );
  }
}
