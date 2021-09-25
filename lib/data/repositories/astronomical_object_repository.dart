import 'package:codetomobile/data/local_database/local_database.dart';
import 'package:codetomobile/data/models/astronomical_object.dart';
import 'package:codetomobile/data/rest_client/rest_client.dart';

class AstronomicalObjectRepository {
  RestClient _restClient;
  LocalDatabase _localDatabase;

  AstronomicalObjectRepository(this._restClient, this._localDatabase);

  Future<List<AstronomicalObject>> fetchAstronomicalObject() async {
    return await _restClient.getAstronomicalObjects();
  }

  Future<List<AstronomicalObject>> getFavoritesAstronomicalObjects() async {
    return (await _localDatabase.query(AstronomicalObject.tableName))
        .map((json) => AstronomicalObject.fromJson(json))
        .toList();
  }

  Future<int> saveFavoriteAstronomicalObject(
      AstronomicalObject astronomicalObject) async {
    return await _localDatabase.insertQuery(
        AstronomicalObject.tableName, astronomicalObject.toJson());
  }

  Future<int> deleteFavoriteAstronomicalObject(String apodSite) async {
    return await _localDatabase.delete(AstronomicalObject.tableName,
        AstronomicalObject.apodSiteColumnName, apodSite);
  }
}
