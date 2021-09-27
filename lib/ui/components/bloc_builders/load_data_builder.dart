import 'package:codetomobile/bloc/abstract/load_data/load_data_bloc.dart';
import 'package:codetomobile/shared/errors.dart';
import 'package:codetomobile/shared/view/dimensions.dart';
import 'package:codetomobile/ui/components/custom/custom_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoadDataBlocBuilder extends StatelessWidget {
  final LoadDataBloc loadDataBloc;
  final Widget Function(dynamic data, bool showInProgress) buildSuccess;
  final Widget Function(dynamic exception, bool showInProgress)? buildError;
  final Widget Function(bool showInProgress)? buildInProgress;
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
          if (current is LoadDataInProgressState && !current.showInProgress) {
            return false;
          }

          return true;
        },
        builder: (BuildContext context, state) {
          Widget? finalWidget;

          if (state is LoadDataInitialState) {
            finalWidget = _buildInitialState();
          } else if (state is LoadDataInProgressState) {
            finalWidget = _buildInProgress(state.showInProgress);
          } else if (state is LoadDataFailureState) {
            finalWidget =
                _buildError(context, state.loadDataError, state.showInProgress);
          } else if (state is LoadDataSuccessState) {
            finalWidget = buildSuccess(loadDataBloc.data, state.showInProgress);
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
      return const SliverFillRemaining(
        child: const Center(
          child: const CircularProgressIndicator(),
        ),
      );
    }

    return const Center(
      child: const CircularProgressIndicator(),
    );
  }

  Widget _buildInProgress(bool showInProgress) {
    if (buildInProgress != null) {
      return buildInProgress!(showInProgress);
    }

    if (isSliver) {
      return const SliverFillRemaining(
        child: const Center(
          child: const CircularProgressIndicator(),
        ),
      );
    }

    return const Center(
      child: const CircularProgressIndicator(),
    );
  }

  Widget _buildError(
      BuildContext context, LoadDataError error, bool showInProgress) {
    if (buildError != null) {
      return buildError!(error, showInProgress);
    }

    if (isSliver) {
      return SliverFillRemaining(
        child: _widgetFromError(context, error),
      );
    }

    return _widgetFromError(context, error);
  }

  Widget _widgetFromError(BuildContext context, LoadDataError loadDataError) {
    switch (loadDataError) {
      case LoadDataError.UNDEFINED:
        return CustomInfo(
          widget: IconButton(
            iconSize: Dimensions.veryHuge,
            alignment: Alignment.topCenter,
            icon: const Icon(
              Icons.refresh,
            ),
            onPressed: () {
              loadDataBloc.add(LoadDataReloadEvent(showInProgress: true));
            },
          ),
          infoText: AppLocalizations.of(context)!.error_text_undefined,
          infoDescription:
              AppLocalizations.of(context)!.error_description_undefined,
        );
      case LoadDataError.TIMEOUT:
        return CustomInfo(
          widget: IconButton(
            iconSize: Dimensions.veryHuge,
            alignment: Alignment.topCenter,
            icon: const Icon(
              Icons.refresh,
            ),
            onPressed: () {
              loadDataBloc.add(LoadDataReloadEvent(showInProgress: true));
            },
          ),
          infoText: AppLocalizations.of(context)!.error_text_timeout,
          infoDescription:
              AppLocalizations.of(context)!.error_description_timeout,
        );
    }
  }
}
