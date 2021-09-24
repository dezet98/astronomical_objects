import 'package:codetomobile/bloc/abstract/load_data/load_data_bloc.dart';
import 'package:codetomobile/data/models/astronomical_object.dart';
import 'package:codetomobile/data/rest_client/rest_client.dart';

class FetchAtronomicalObjectsBloc extends LoadDataBloc {
  RestClient _restClient;

  FetchAtronomicalObjectsBloc(this._restClient);

  @override
  Future<List<AstronomicalObject>> load() {
    return _restClient.getAstronomicalObjects();
  }
}
