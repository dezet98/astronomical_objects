import 'package:codetomobile/bloc/abstract/fetch/fetch_bloc.dart';
import 'package:codetomobile/shared/errors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchBlocBuilder extends StatelessWidget {
  final FetchBloc fetchBloc;
  final Widget Function(dynamic data, bool isRefresh) buildSuccess;
  final Widget Function(dynamic exception, bool isRefresh)? buildError;
  final Widget Function(bool isRefresh)? buildInProgress;
  final Widget? buildInitial;
  final bool isSliver;

  FetchBlocBuilder({
    required this.fetchBloc,
    required this.buildSuccess,
    this.buildError,
    this.buildInProgress,
    this.buildInitial,
    this.isSliver = false,
  });

  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: fetchBloc,
        builder: (BuildContext context, state) {
          Widget? finalWidget;

          if (state is FetchInitialState) {
            finalWidget = _buildInitialState();
          } else if (state is FetchInProgressState) {
            finalWidget = _buildInProgress(state.isRefresh);
          } else if (state is FetchFailureState) {
            finalWidget = _buildError(state.fetchingError, state.isRefresh);
          } else if (state is FetchSuccessState) {
            finalWidget = buildSuccess(state.data, state.isRefresh);
          }

          assert(finalWidget != null);

          return finalWidget!;
        });
  }

  Widget _buildInitialState() {
    if (buildInProgress != null) {
      return buildInitial!;
    }

    if (isSliver) {
      return SliverFillRemaining(
        child: Container(),
      );
    }

    return CircularProgressIndicator();
  }

  Widget _buildInProgress(bool isRefresh) {
    if (buildInProgress != null) {
      return buildInProgress!(isRefresh);
    }

    if (isSliver) {
      return SliverFillRemaining(
        child: Container(),
      );
    }

    return CircularProgressIndicator();
  }

  Widget _buildError(FetchError error, bool isRefresh) {
    if (buildError != null) {
      return buildError!(error, isRefresh);
    }

    if (isSliver) {
      return SliverFillRemaining(
        child: Container(),
      );
    }

    return Text("Error");
  }
}
