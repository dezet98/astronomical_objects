import 'package:codetomobile/bloc/abstract/load_data/load_data_bloc.dart';
import 'package:codetomobile/bloc/specific/load_favorites_astronomical_objects_bloc.dart';
import 'package:codetomobile/data/models/astronomical_object.dart';
import 'package:codetomobile/shared/extension.dart';
import 'package:codetomobile/shared/view/dimensions.dart';
import 'package:codetomobile/ui/components/bloc_builders/load_data_builder.dart';
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
  return Padding(
    padding: const EdgeInsets.only(
      bottom: Dimensions.huge,
      left: Dimensions.veryHuge,
      right: Dimensions.veryHuge,
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/empty_state_box.png'),
          const SizedBox(height: Dimensions.huge),
          Text(
            AppLocalizations.of(context)!.favorite_screen_empty_state_text,
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: Dimensions.basic),
          Text(
            AppLocalizations.of(context)!
                .favorite_screen_empty_state_description,
            style: Theme.of(context).textTheme.subtitle1,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}

Future<void> _onRefreshData(BuildContext context) async {
  context
      .bloc<LoadFavoritesAtronomicalObjectsBloc>()
      .add(LoadDataReloadEvent());

  await Future.delayed(Duration(seconds: 2));
}
