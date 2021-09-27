import 'package:codetomobile/bloc/abstract/load_data/load_data_bloc.dart';
import 'package:codetomobile/data/models/astronomical_object.dart';
import 'package:codetomobile/data/repositories/astronomical_object_repository.dart';
import 'package:collection/collection.dart';

class LoadFavoritesAtronomicalObjectsBloc
    extends LoadDataBloc<List<AstronomicalObject>> {
  AstronomicalObjectRepository _astronomicalObjectRepository;

  LoadFavoritesAtronomicalObjectsBloc(this._astronomicalObjectRepository)
      : super([]);

  int get count => data.length;

  @override
  Future<List<AstronomicalObject>> load() async {
    return await _astronomicalObjectRepository
        .getFavoritesAstronomicalObjects()
        .timeout(Duration(seconds: 6));
  }

  bool isFavorite(String? apodSite) {
    if (apodSite == null) return false;

    return data.firstWhereOrNull((element) => element.apodSite == apodSite) !=
        null;
  }

  void removeLocallyElement(String? apochSite) {
    data.removeWhere((element) => element.apodSite == apochSite);
  }

  void addLocallyElement(AstronomicalObject astronomicalObject) {
    data.add(astronomicalObject);
  }
}
