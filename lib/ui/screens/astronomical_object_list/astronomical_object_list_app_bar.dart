import 'package:codetomobile/bloc/abstract/load_data/load_data_bloc.dart';
import 'package:codetomobile/bloc/specific/load_favorites_astronomical_objects_bloc.dart';
import 'package:codetomobile/bloc/specific/router/router_bloc.dart';
import 'package:codetomobile/shared/extension.dart';
import 'package:codetomobile/shared/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:icon_badge/icon_badge.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    title: Text(
      AppLocalizations.of(context)!.astronomical_object_list_app_bar_title,
    ),
    actions: [
      BlocBuilder(
          bloc: context.bloc<LoadFavoritesAtronomicalObjectsBloc>(),
          buildWhen: (previous, current) {
            return current is LoadDataInitialState ||
                    current is LoadDataSuccessState
                ? true
                : false;
          },
          builder: (context, state) {
            return IconBadge(
              icon: const Icon(Icons.favorite),
              itemCount:
                  context.bloc<LoadFavoritesAtronomicalObjectsBloc>().count,
              badgeColor: Colors.red,
              itemColor: Colors.white,
              hideZero: true,
              onTap: () {
                context.bloc<RouterBloc>().add(
                    RouterNavigateToEvent(RouteName.FAVORITES_LIST_SCREEN));
              },
            );
          }),
    ],
    backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
  );
}
