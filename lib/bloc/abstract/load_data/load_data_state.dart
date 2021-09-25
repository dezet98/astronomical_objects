part of 'load_data_bloc.dart';

abstract class LoadDataState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadDataInitialState extends LoadDataState {}

class LoadDataInProgressState extends LoadDataState {
  final bool isRefresh;

  LoadDataInProgressState({this.isRefresh = false});
}

class LoadDataSuccessState<T> extends LoadDataState {
  final bool isRefresh;

  LoadDataSuccessState({this.isRefresh = false});
}

class LoadDataFailureState extends LoadDataState {
  final LoadDataError loadDataError;
  final bool isRefresh;

  LoadDataFailureState({required this.loadDataError, this.isRefresh = false});
}
