import 'package:codetomobile/bloc/abstract/load_data/load_data_bloc.dart';
import 'package:codetomobile/data/models/astronomical_object.dart';
import 'package:codetomobile/data/repositories/astronomical_object_repository.dart';
import 'package:collection/collection.dart';

class LoadFavoritesAtronomicalObjectsBloc extends LoadDataBloc {
  AstronomicalObjectRepository _astronomicalObjectRepository;

  LoadFavoritesAtronomicalObjectsBloc(this._astronomicalObjectRepository);

  int count = 0;
  List<AstronomicalObject> astronomicalObject = [];

  @override
  Future<List<AstronomicalObject>> load() async {
    var objects =
        await _astronomicalObjectRepository.getFavoritesAstronomicalObjects();

    count = objects.length;
    astronomicalObject = objects;

    return objects;
  }

  bool isFavorite(String? apodSite) {
    if (apodSite == null) return false;

    return astronomicalObject
            .firstWhereOrNull((element) => element.apodSite == apodSite) !=
        null;
  }
}
