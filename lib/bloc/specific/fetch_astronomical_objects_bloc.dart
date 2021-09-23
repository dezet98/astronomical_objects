import 'package:codetomobile/bloc/abstract/fetch/fetch_bloc.dart';
import 'package:codetomobile/data/models/astronomical_object.dart';
import 'package:codetomobile/data/rest_client/rest_client.dart';

class FetchAtronomicalObjectsBloc extends FetchBloc {
  RestClient _restClient;

  FetchAtronomicalObjectsBloc(this._restClient);

  @override
  Future<List<AstronomicalObject>> fetch() {
    return _restClient.getAstronomicalObjects();
  }
}
