import 'package:bloc/bloc.dart';
import 'package:codetomobile/shared/errors.dart';
import 'package:codetomobile/shared/routes.dart';
import 'package:codetomobile/ui/screens/astronomical_object_list.dart';
import 'package:codetomobile/ui/screens/atronomical_object_details.dart';
import 'package:codetomobile/ui/screens/favorite/favorite_list_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'router_event.dart';
part 'router_state.dart';

class RouterBloc extends Bloc<RouterEvent, RouterState> {
  RouterBloc()
      : super(RouterInitialState(
            _fromRouteName(RouteName.ASTRONOMICAL_OBJECT_LIST, null)!)) {
    on<RouterNavigateToEvent>((event, emit) {
      try {
        emit.call(RouterChangeRouteInProgressState());

        Widget? screen = _fromRouteName(event.destination, event.routeArgs);

        if (screen == null) {
          emit.call(RouterChangeRouteFailureState(RouterError.ARGS_ERROR));
        } else {
          emit.call(
            RouterChangeRouteSuccessState(
              MaterialPageRoute(builder: (_) => screen),
            ),
          );
        }
      } catch (e) {
        emit.call(RouterChangeRouteFailureState(RouterError.UNDEFINED));
      }
    });
  }
}

Widget? _fromRouteName(RouteName routeName, RouteArgs? routeArgs) {
  try {
    switch (routeName) {
      case RouteName.ASTRONOMICAL_OBJECT_LIST:
        return AstronomicalObjectList();
      case RouteName.ASTRONOMICAL_OBJECT_DETAILS:
        AtronomicalObjectDetailsArgs args =
            routeArgs as AtronomicalObjectDetailsArgs;
        return AtronomicalObjectDetails(args: args);
      case RouteName.FAVORITES_LIST_SCREEN:
        return FavoriteListScreen();
    }
  } catch (e) {
    return null;
  }
}

abstract class RouteArgs {}
