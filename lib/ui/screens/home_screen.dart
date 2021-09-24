import 'package:codetomobile/bloc/specific/router/router_bloc.dart';
import 'package:codetomobile/shared/extension.dart';
import 'package:codetomobile/shared/logger/app_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: context.bloc<RouterBloc>(),
      listener: routerBlocListener,
      builder: (BuildContext context, RouterState state) {
        return (state as RouterInitialState).initialScreen;
      },
      buildWhen: (previous, current) {
        return current is RouterInitialState ? true : false;
      },
    );
  }
}

void routerBlocListener(BuildContext context, RouterState state) {
  if (state is RouterChangeRouteSuccessState) {
    Navigator.push(context, state.route);
  } else if (state is RouterChangeRouteFailureState) {
    AppLogger().log(
      message: "Navigation Error: ${state.routerError}\n ${state.message}",
      logLevel: LogLevel.error,
    );
  }
}
