part of 'router_bloc.dart';

abstract class RouterState extends Equatable {
  const RouterState();

  @override
  List<Object> get props => [];
}

class RouterInitialState extends RouterState {
  final Widget initialScreen;

  RouterInitialState(this.initialScreen);
}

class RouterChangeRouteInProgressState extends RouterState {}

class RouterChangeRouteSuccessState extends RouterState {
  final MaterialPageRoute<dynamic> route;

  RouterChangeRouteSuccessState(this.route);
}

class RouterChangeRouteFailureState extends RouterState {
  final RouterError routerError;
  final String? message;

  RouterChangeRouteFailureState(this.routerError, {this.message});
}
