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
    try {
      emit(FavoriteAstronomicalObjectChangeInProgressState());
      if (isFavorite) {
        await _removeFromLocalDatabase();
      } else {
        await _addToLocalDatabase();
      }
      _loadFavoritesAtronomicalObjectsBloc.add(LoadDataReloadEvent());
      emit(FavoriteAstronomicalObjectChangeSuccessState());
    } catch (e) {
      emit(FavoriteAstronomicalObjectChangeFailureState());
    }
  }

  Future<void> remove() async {
    try {
      emit(FavoriteAstronomicalObjectChangeInProgressState());

      _loadFavoritesAtronomicalObjectsBloc
          .removeLocallyElement(_astronomicalObject.apodSite);
      _loadFavoritesAtronomicalObjectsBloc.add(LoadDataRefreshEvent());

      await _removeFromLocalDatabase();

      emit(FavoriteAstronomicalObjectChangeSuccessState());
    } catch (e) {
      emit(FavoriteAstronomicalObjectChangeFailureState());
    }
  }

  Future<void> _removeFromLocalDatabase() async {
    await _astronomicalObjectRepository
        .deleteFavoriteAstronomicalObject(_astronomicalObject.apodSite ?? "")
        .timeout(Duration(seconds: 2));
    isFavorite = false;
  }

  Future<void> _addToLocalDatabase() async {
    await _astronomicalObjectRepository
        .saveFavoriteAstronomicalObject(_astronomicalObject)
        .timeout(Duration(seconds: 2));
    isFavorite = true;
  }
}
