import 'package:codetomobile/bloc/specific/favorite_astronomical_object/favorite_astronomical_object_cubit.dart';
import 'package:codetomobile/bloc/specific/load_favorites_astronomical_objects_bloc.dart';
import 'package:codetomobile/data/models/astronomical_object.dart';
import 'package:codetomobile/data/repositories/astronomical_object_repository.dart';
import 'package:codetomobile/shared/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeartBuilder extends StatelessWidget {
  final AstronomicalObject _astronomicalObject;

  const HeartBuilder(this._astronomicalObject, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FavoriteAstronomicalObjectCubit(
        RepositoryProvider.of<AstronomicalObjectRepository>(context),
        _astronomicalObject,
        context.bloc<LoadFavoritesAtronomicalObjectsBloc>(),
      ),
      child: Builder(
        builder: (BuildContext context) => IconButton(
          icon: BlocBuilder(
            bloc: context.cubit<FavoriteAstronomicalObjectCubit>(),
            buildWhen: (previous, current) {
              return current is FavoriteAstronomicalObjectInitialState ||
                      current is FavoriteAstronomicalObjectChangeSuccessState
                  ? true
                  : false;
            },
            builder: (context, state) {
              return context.cubit<FavoriteAstronomicalObjectCubit>().isFavorite
                  ? const Icon(Icons.favorite_outlined)
                  : const Icon(Icons.favorite_outline_rounded);
            },
          ),
          onPressed: () => _onFavoriteIconPressed(context),
          color: Colors.white,
        ),
      ),
    );
  }

  void _onFavoriteIconPressed(BuildContext context) async {
    await context.cubit<FavoriteAstronomicalObjectCubit>().changeFavorite();
  }
}
