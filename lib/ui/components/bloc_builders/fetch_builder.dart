import 'package:codetomobile/bloc/abstract/load_data/load_data_bloc.dart';
import 'package:codetomobile/shared/errors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadDataBlocBuilder extends StatelessWidget {
  final LoadDataBloc loadDataBloc;
  final Widget Function(dynamic data, bool isRefresh) buildSuccess;
  final Widget Function(dynamic exception, bool isRefresh)? buildError;
  final Widget Function(bool isRefresh)? buildInProgress;
  final Widget? buildInitial;
  final bool isSliver;

  LoadDataBlocBuilder({
    required this.loadDataBloc,
    required this.buildSuccess,
    this.buildError,
    this.buildInProgress,
    this.buildInitial,
    this.isSliver = false,
  });

  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: loadDataBloc,
        buildWhen: (previous, current) {
          if (current is LoadDataInProgressState && current.isRefresh) {
            return false;
          }

          return true;
        },
        builder: (BuildContext context, state) {
          Widget? finalWidget;

          if (state is LoadDataInitialState) {
            finalWidget = _buildInitialState();
          } else if (state is LoadDataInProgressState) {
            finalWidget = _buildInProgress(state.isRefresh);
          } else if (state is LoadDataFailureState) {
            finalWidget = _buildError(state.loadDataError, state.isRefresh);
          } else if (state is LoadDataSuccessState) {
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

  Widget _buildError(LoadDataError error, bool isRefresh) {
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
