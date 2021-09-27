part of 'load_data_bloc.dart';

abstract class LoadDataState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadDataInitialState extends LoadDataState {}

class LoadDataInProgressState extends LoadDataState {
  final bool showInProgress;

  LoadDataInProgressState({this.showInProgress = false});
}

class LoadDataSuccessState extends LoadDataState {
  final bool showInProgress;

  LoadDataSuccessState({this.showInProgress = false});
}

class LoadDataFailureState extends LoadDataState {
  final LoadDataError loadDataError;
  final bool showInProgress;

  LoadDataFailureState(
      {required this.loadDataError, this.showInProgress = false});
}
