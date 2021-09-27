import 'package:cached_network_image/cached_network_image.dart';
import 'package:codetomobile/bloc/specific/router/router_bloc.dart';
import 'package:codetomobile/data/models/astronomical_object.dart';
import 'package:codetomobile/shared/extension.dart';
import 'package:codetomobile/shared/routes.dart';
import 'package:codetomobile/shared/view/dimensions.dart';
import 'package:codetomobile/ui/components/custom/custom_not_supported_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../astronomical_object_details/atronomical_object_details_screen.dart';

Widget buildFavoriteListTile(
    BuildContext context, AstronomicalObject astronomicalObject) {
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(
        horizontal: Dimensions.basic, vertical: Dimensions.basic),
    title: Text(
      astronomicalObject.title ?? "",
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
    subtitle: Text(
      astronomicalObject.description ?? "",
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    ),
    leading: ClipRRect(
      borderRadius: BorderRadius.circular(Dimensions.small),
      child: CachedNetworkImage(
        imageUrl: astronomicalObject.url ?? "",
        height: 62,
        width: 54,
        fit: BoxFit.cover,
        placeholder: (context, url) =>
            const Center(child: const CircularProgressIndicator()),
        errorWidget: (context, url, error) => const CustomNotSupportedImage(),
      ),
    ),
    onTap: () => _routeToAstronomicalObjectDetails(context, astronomicalObject),
  );
}

void _routeToAstronomicalObjectDetails(
    BuildContext context, AstronomicalObject astronomicalObject) {
  context.bloc<RouterBloc>().add(
        RouterNavigateToEvent(
          RouteName.ASTRONOMICAL_OBJECT_DETAILS,
          routeArgs: AtronomicalObjectDetailsArgs(
            astronomicalObject: astronomicalObject,
          ),
        ),
      );
}
