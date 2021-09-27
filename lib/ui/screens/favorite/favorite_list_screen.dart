import 'package:codetomobile/bloc/abstract/load_data/load_data_bloc.dart';
import 'package:codetomobile/bloc/specific/load_favorites_astronomical_objects_bloc.dart';
import 'package:codetomobile/data/models/astronomical_object.dart';
import 'package:codetomobile/shared/extension.dart';
import 'package:codetomobile/ui/components/bloc_builders/load_data_builder.dart';
import 'package:codetomobile/ui/components/custom/custom_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'favorite_list_builder.dart';

class FavoriteListScreen extends StatelessWidget {
  const FavoriteListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: RefreshIndicator(
        onRefresh: () async => await _onRefreshData(context),
        child: LoadDataBlocBuilder(
          loadDataBloc: context.bloc<LoadFavoritesAtronomicalObjectsBloc>(),
          buildSuccess: (dynamic data, bool isRefresh) {
            if ((data as List<AstronomicalObject>).length == 0) {
              return _buildEmptyState(context);
            }
            return buildFavoriteList(context, data);
          },
        ),
      ),
    );
  }
}

AppBar _buildAppBar(BuildContext context) {
  return AppBar(
    title: Text(
      AppLocalizations.of(context)!.favorite_screen_app_bar_title,
    ),
    backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
  );
}

Widget _buildEmptyState(BuildContext context) {
  return CustomInfo(
    widget: Image.asset('assets/empty_state_box.png'),
    infoText: AppLocalizations.of(context)!.favorite_screen_empty_state_text,
    infoDescription:
        AppLocalizations.of(context)!.favorite_screen_empty_state_description,
  );
}

Future<void> _onRefreshData(BuildContext context) async {
  context
      .bloc<LoadFavoritesAtronomicalObjectsBloc>()
      .add(LoadDataReloadEvent());

  await Future.delayed(Duration(milliseconds: 1500));
}
