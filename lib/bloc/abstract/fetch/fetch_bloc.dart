import 'package:bloc/bloc.dart';
import 'package:codetomobile/shared/errors.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'fetch_event.dart';
part 'fetch_state.dart';

abstract class FetchBloc<ResultType> extends Bloc<FetchEvent, FetchState> {
  Future<ResultType> fetch();

  FetchBloc() : super(FetchInitialState()) {
    on<FetchEvent>((event, emit) async {
      bool isRefresh = event is FetchRefreshEvent;

      try {
        emit.call(FetchInProgressState(isRefresh: isRefresh));
        ResultType data = await fetch();
        emit.call(FetchSuccessState(data: data, isRefresh: isRefresh));
      } catch (e) {
        emit.call(FetchFailureState(
            fetchingError: FetchError.undefined, isRefresh: isRefresh));
      }
    });

    add(FetchInitialEvent());
  }
}
