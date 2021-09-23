import 'package:codetomobile/bloc/abstract/fetch/fetch_bloc.dart';
import 'package:codetomobile/data/models/astronomical_object.dart';
import 'package:codetomobile/data/rest_client/rest_client.dart';
import 'package:dio/dio.dart';

class FetchAtronomicalObjectsBloc extends FetchBloc {
  @override
  Future<List<AstronomicalObject>> fetch() {
    final client =
        RestClient((Dio(BaseOptions(contentType: "application/json"))));

    return client.getAstronomicalObjects();
  }
}
