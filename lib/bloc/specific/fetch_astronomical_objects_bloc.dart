import 'package:codetomobile/bloc/abstract/load_data/load_data_bloc.dart';
import 'package:codetomobile/data/models/astronomical_object.dart';
import 'package:codetomobile/data/repositories/astronomical_object_repository.dart';

class FetchAtronomicalObjectsBloc extends LoadDataBloc {
  AstronomicalObjectRepository _astronomicalObjectRepository;

  FetchAtronomicalObjectsBloc(this._astronomicalObjectRepository);

  @override
  Future<List<AstronomicalObject>> load() {
    return _astronomicalObjectRepository.fetchAstronomicalObject();
  }
}
