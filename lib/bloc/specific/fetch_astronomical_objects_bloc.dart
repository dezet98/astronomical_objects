import 'package:codetomobile/bloc/abstract/load_data/load_data_bloc.dart';
import 'package:codetomobile/data/models/astronomical_object.dart';
import 'package:codetomobile/data/repositories/astronomical_object_repository.dart';

class FetchAtronomicalObjectsBloc
    extends LoadDataBloc<List<AstronomicalObject>> {
  AstronomicalObjectRepository _astronomicalObjectRepository;

  FetchAtronomicalObjectsBloc(this._astronomicalObjectRepository) : super([]);

  @override
  Future<List<AstronomicalObject>> load() async {
    return await _astronomicalObjectRepository
        .fetchAstronomicalObject()
        .timeout(
          Duration(seconds: 6),
        );
  }
}
