import 'package:bloc/bloc.dart';
import 'package:codetomobile/bloc/abstract/load_data/load_data_bloc.dart';
import 'package:codetomobile/bloc/specific/load_favorites_astronomical_objects_bloc.dart';
import 'package:codetomobile/data/models/astronomical_object.dart';
import 'package:codetomobile/data/repositories/astronomical_object_repository.dart';
import 'package:equatable/equatable.dart';

part 'favorite_astronomical_object_state.dart';

class FavoriteAstronomicalObjectCubit
    extends Cubit<FavoriteAstronomicalObjectState> {
  AstronomicalObjectRepository _astronomicalObjectRepository;
  AstronomicalObject _astronomicalObject;
  LoadFavoritesAtronomicalObjectsBloc _loadFavoritesAtronomicalObjectsBloc;
  late bool isFavorite;

  FavoriteAstronomicalObjectCubit(this._astronomicalObjectRepository,
      this._astronomicalObject, this._loadFavoritesAtronomicalObjectsBloc)
      : super(FavoriteAstronomicalObjectInitialState()) {
    isFavorite = _loadFavoritesAtronomicalObjectsBloc
        .isFavorite(_astronomicalObject.apodSite);
  }

  Future<void> changeFavorite() async {
    if (state is FavoriteAstronomicalObjectChangeInProgressState) {
      return;
    }

    try {
      emit(FavoriteAstronomicalObjectChangeInProgressState());
      if (isFavorite) {
        await _remove();
      } else {
        await _add();
      }
      _loadFavoritesAtronomicalObjectsBloc.add(LoadDataRefreshEvent());
      emit(FavoriteAstronomicalObjectChangeSuccessState());
    } catch (e) {
      emit(FavoriteAstronomicalObjectChangeFailureState());
    }
  }

  Future<void> _remove() async {
    await _astronomicalObjectRepository
        .deleteFavoriteAstronomicalObject(_astronomicalObject.apodSite ?? "");
    isFavorite = false;
  }

  Future<void> _add() async {
    await _astronomicalObjectRepository
        .saveFavoriteAstronomicalObject(_astronomicalObject);
    isFavorite = true;
  }
}
