import 'package:bloc/bloc.dart';
import 'package:codetomobile/shared/errors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'load_data_event.dart';
part 'load_data_state.dart';

abstract class LoadDataBloc<ResultType>
    extends Bloc<LoadDataEvent, LoadDataState> {
  Future<ResultType> load();
  bool loadComplete = false;

  LoadDataBloc() : super(LoadDataInitialState()) {
    on<LoadDataEvent>((event, emit) async {
      loadComplete = false;
      bool isRefresh = event is LoadDataRefreshEvent;
      try {
        emit.call(LoadDataInProgressState(isRefresh: isRefresh));
        ResultType data = await load().whenComplete(() => loadComplete = true);
        emit.call(LoadDataSuccessState(data: data, isRefresh: isRefresh));
      } catch (e) {
        emit.call(LoadDataFailureState(
            loadDataError: LoadDataError.undefined, isRefresh: isRefresh));
      }
    });

    add(LoadDataInitialEvent());
  }
}
