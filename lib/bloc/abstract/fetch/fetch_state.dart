part of 'fetch_bloc.dart';

abstract class FetchState extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchInitialState extends FetchState {}

class FetchInProgressState extends FetchState {
  final bool isRefresh;

  FetchInProgressState({this.isRefresh = false});
}

class FetchSuccessState<T> extends FetchState {
  final T data;
  final bool isRefresh;

  FetchSuccessState({required this.data, this.isRefresh = false});
}

class FetchFailureState extends FetchState {
  final FetchError fetchingError;
  final bool isRefresh;

  FetchFailureState({required this.fetchingError, this.isRefresh = false});
}
