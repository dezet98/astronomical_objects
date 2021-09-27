part of 'load_data_bloc.dart';

@immutable
abstract class LoadDataEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// first time load data
class LoadDataInitialEvent extends LoadDataEvent {
  final bool showInProgress;
  LoadDataInitialEvent({this.showInProgress = false});
}

// refresh widget without load data
class LoadDataRefreshEvent extends LoadDataEvent {
  final bool showInProgress;

  LoadDataRefreshEvent({this.showInProgress = false});
}

// refresh widget with reload data again
class LoadDataReloadEvent extends LoadDataEvent {
  final bool showInProgress;

  LoadDataReloadEvent({this.showInProgress = false});
}
