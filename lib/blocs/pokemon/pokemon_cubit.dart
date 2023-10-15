import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pokemon_app/services/dio_helper.dart';

import '../../model/pokemon_model.dart';

part 'pokemon_state.dart';

class PokemonCubit extends Cubit<PokemonState> {
  PokemonCubit() : super(PokemonInitial());

  static PokemonCubit get(context) => BlocProvider.of(context);

  PokemonModel? pokemonModel;

  getAllPokemons() {
    emit(PokemonGetLoadingState());
    DioHelper.getData()
        .then((value) {
      emit(PokemonGetSuccessState());
      print(value.statusCode);
      pokemonModel = PokemonModel.fromJson(jsonDecode(value.data));
      print(pokemonModel);
    })
        .catchError((error) {
      emit(PokemonGetErrorState());
      print(error);
    });
  }
}
