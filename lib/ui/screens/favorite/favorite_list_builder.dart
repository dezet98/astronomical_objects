import 'package:codetomobile/bloc/specific/favorite_astronomical_object/favorite_astronomical_object_cubit.dart';
import 'package:codetomobile/bloc/specific/load_favorites_astronomical_objects_bloc.dart';
import 'package:codetomobile/data/models/astronomical_object.dart';
import 'package:codetomobile/data/repositories/astronomical_object_repository.dart';
import 'package:codetomobile/shared/extension.dart';
import 'package:codetomobile/shared/view/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'favorite_list_tile.dart';

Widget buildFavoriteList(
    BuildContext context, List<AstronomicalObject> astronomicalObjects) {
  return ListView.builder(
    itemCount: astronomicalObjects.length,
    itemBuilder: (context, index) {
      AstronomicalObject object = astronomicalObjects[index];

      return BlocProvider(
        create: (_) => FavoriteAstronomicalObjectCubit(
          RepositoryProvider.of<AstronomicalObjectRepository>(context),
          object,
          context.bloc<LoadFavoritesAtronomicalObjectsBloc>(),
        ),
        child: Builder(
          builder: (context) => Column(
            children: [
              Dismissible(
                key: Key(object.apodSite ?? ""),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) => onDismissed(context, direction),
                background: _buildDismissBackground(context),
                child: buildFavoriteListTile(context, object),
              ),
              Divider(
                indent: Dimensions.basic,
                endIndent: Dimensions.basic,
                height: 0.0,
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildDismissBackground(BuildContext context) {
  return Container(
    alignment: Alignment.centerRight,
    padding: EdgeInsets.only(right: Dimensions.basic),
    color: Colors.red,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          AppLocalizations.of(context)!.favorite_screen_delete_action,
          style: Theme.of(context)
              .textTheme
              .button!
              .copyWith(color: Theme.of(context).cardColor),
        ),
        SizedBox(width: Dimensions.basic),
        Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ],
    ),
  );
}

void onDismissed(BuildContext context, DismissDirection direction) {
  context.cubit<FavoriteAstronomicalObjectCubit>().remove();
}
