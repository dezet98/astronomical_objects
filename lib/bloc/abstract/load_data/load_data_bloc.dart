import 'dart:async';

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
        emit.call(
            LoadDataInProgressState(showInProgress: event.showInProgress));
        emit.call(LoadDataSuccessState(showInProgress: event.showInProgress));
      } catch (e) {
        _handleExceptions(e, emit, event.showInProgress);
      }
    });

    on<LoadDataInitialEvent>((event, emit) async {
      try {
        emit.call(
            LoadDataInProgressState(showInProgress: event.showInProgress));
        data = await load();
        emit.call(LoadDataSuccessState(showInProgress: event.showInProgress));
      } catch (e) {
        _handleExceptions(e, emit, event.showInProgress);
      }
    });

    on<LoadDataReloadEvent>((event, emit) async {
      try {
        emit.call(
            LoadDataInProgressState(showInProgress: event.showInProgress));
        data = await load();
        emit.call(LoadDataSuccessState(showInProgress: event.showInProgress));
      } catch (e) {
        _handleExceptions(e, emit, event.showInProgress);
      }
    });

    add(LoadDataInitialEvent(showInProgress: true));
  }

  void _handleExceptions(
      Object e, Emitter<LoadDataState> emit, bool showInProgress) {
    LoadDataError loadDataError = LoadDataError.UNDEFINED;

    if (e is TimeoutException) {
      loadDataError = LoadDataError.TIMEOUT;
    }

    emit.call(
      LoadDataFailureState(
          loadDataError: loadDataError, showInProgress: showInProgress),
    );
  }
}

enum LoadData { INITIAL, REFRESH_WITH_LOAD, REFRESH }
