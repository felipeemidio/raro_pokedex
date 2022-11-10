import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:raro_pokedex/core/entites/pokemon.dart';
import 'package:raro_pokedex/modules/home/cubit/pokemon_detail_cubit.dart';
import 'package:raro_pokedex/modules/home/cubit/pokemon_detail_cubit_state.dart';

class PokemonDetailPage extends StatefulWidget {
  final Pokemon pokemon;
  const PokemonDetailPage({super.key, required this.pokemon});
  

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  late PokemonDetailCubit _pokemonDetailCubit;

  @override
  void initState() {
    _pokemonDetailCubit = Modular.get<PokemonDetailCubit>();
    _pokemonDetailCubit.getDetails(widget.pokemon.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.pokemon.name),),
      body: BlocConsumer<PokemonDetailCubit, PokemonDetailCubitState>(
        bloc: _pokemonDetailCubit,
        listener: (context, state) {
          if (state.status == PokemonDetailCubitStatus.error) {
            final snackBar = SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.error!.message),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          if (state.detailsPokemon != null) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SvgPicture.network(
                    state.detailsPokemon!.image,
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
                Row(
                  children: [Text(state.detailsPokemon!.types[0])],
                )
              ],
            );
          }
          return Center(child: const CircularProgressIndicator());
        },
      ),
    );
  }
}
