import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/screens/single_pokemon_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../blocs/pokemon/pokemon_cubit.dart';
class PokemonsScreen extends StatefulWidget {
  const PokemonsScreen({super.key});

  @override
  State<PokemonsScreen> createState() => _PokemonsScreenState();
}

class _PokemonsScreenState extends State<PokemonsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PokemonCubit, PokemonState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = PokemonCubit.get(context);
        return cubit.pokemonModel==null
            ? const Center(child: CircularProgressIndicator())
            : Scaffold(
            appBar: AppBar(
              title: const Text(
                'Poke App',
              ),
              centerTitle: true,
              backgroundColor: const Color(0xff00BCD4),
            ),
            body: GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 18,
                  crossAxisSpacing: 18,
                  crossAxisCount: 2),
              itemCount: cubit.pokemonModel!.pokemon!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SinglePokemonScreen(
                          pokemon: cubit.pokemonModel!.pokemon![index],
                        ),
                      ),
                    );
                  },
                  child: Material(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          children: [
                            CachedNetworkImage(
                              imageUrl:cubit.pokemonModel!.pokemon![index].img! ,
                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                                  CircularProgressIndicator(value: downloadProgress.progress),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                            Flexible(
                              child: Text(
                                cubit.pokemonModel!.pokemon![index].name!,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ));
      },
    );
  }
}