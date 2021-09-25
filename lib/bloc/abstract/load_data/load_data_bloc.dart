import 'package:bloc/bloc.dart';
import 'package:codetomobile/shared/errors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'load_data_event.dart';
part 'load_data_state.dart';

abstract class LoadDataBloc<ResultType>
    extends Bloc<LoadDataEvent, LoadDataState> {
  Future<ResultType> load();
  late ResultType data;

  LoadDataBloc(ResultType initalData) : super(LoadDataInitialState()) {
    data = initalData;

    on<LoadDataRefreshEvent>((event, emit) async {
      try {
        emit.call(LoadDataInProgressState(isRefresh: true));
        emit.call(LoadDataSuccessState(isRefresh: true));
      } catch (e) {
        emit.call(LoadDataFailureState(
            loadDataError: LoadDataError.undefined, isRefresh: true));
      }
    });

    on<LoadDataInitialEvent>((event, emit) async {
      try {
        emit.call(LoadDataInProgressState());
        data = await load();
        emit.call(LoadDataSuccessState());
      } catch (e) {
        emit.call(LoadDataFailureState(loadDataError: LoadDataError.undefined));
      }
    });

    on<LoadDataReloadEvent>((event, emit) async {
      try {
        emit.call(LoadDataInProgressState(isRefresh: true));
        data = await load();
        emit.call(LoadDataSuccessState(isRefresh: true));
      } catch (e) {
        emit.call(LoadDataFailureState(
            loadDataError: LoadDataError.undefined, isRefresh: true));
      }
    });

    add(LoadDataInitialEvent());
  }
}

enum LoadData { INITIAL, REFRESH_WITH_LOAD, REFRESH }
