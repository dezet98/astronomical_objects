import 'package:codetomobile/bloc/abstract/load_data/load_data_bloc.dart';
import 'package:codetomobile/data/local_database/local_database_service.dart';
import 'package:codetomobile/data/models/astronomical_object.dart';

class LoadFavoritesAtronomicalObjectsBloc extends LoadDataBloc {
  LocalDatabaseService _localDatabaseService;

  LoadFavoritesAtronomicalObjectsBloc(this._localDatabaseService);

  int count = 0;

  @override
  Future<List<AstronomicalObject>> load() async {
    var results =
        await _localDatabaseService.query(AstronomicalObject.tableName);

    var astronomicalObjects = results
        .map((astronomicalObjectJson) =>
            AstronomicalObject.fromJson(astronomicalObjectJson))
        .toList();

    count = astronomicalObjects.length;

    return astronomicalObjects;
  }
}
