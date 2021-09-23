part of 'fetch_bloc.dart';

@immutable
abstract class FetchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchInitialEvent extends FetchEvent {
  FetchInitialEvent();
}

class FetchRefreshEvent extends FetchEvent {
  FetchRefreshEvent();
}
