part of 'load_data_bloc.dart';

@immutable
abstract class LoadDataEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadDataInitialEvent extends LoadDataEvent {
  LoadDataInitialEvent();
}

class LoadDataRefreshEvent extends LoadDataEvent {
  LoadDataRefreshEvent();
}

class LoadDataReloadEvent extends LoadDataEvent {
  LoadDataReloadEvent();
}
