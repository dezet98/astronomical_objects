import 'package:cached_network_image/cached_network_image.dart';
import 'package:codetomobile/bloc/specific/router/router_bloc.dart';
import 'package:codetomobile/data/models/astronomical_object.dart';
import 'package:codetomobile/shared/extension.dart';
import 'package:codetomobile/shared/routes.dart';
import 'package:codetomobile/ui/components/custom/custom_not_supported_image.dart';
import 'package:codetomobile/ui/screens/astronomical_object_details/atronomical_object_details_screen.dart';
import 'package:flutter/material.dart';

Widget buildGridTile(
    BuildContext context, AstronomicalObject astronomicalObject) {
  return GestureDetector(
    onTap: () {
      context.bloc<RouterBloc>().add(RouterNavigateToEvent(
            RouteName.ASTRONOMICAL_OBJECT_DETAILS,
            routeArgs: AtronomicalObjectDetailsArgs(
              astronomicalObject: astronomicalObject,
            ),
          ));
    },
    child: Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: CachedNetworkImage(
              imageUrl: astronomicalObject.url ?? "",
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  const Center(child: const CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
                  const CustomNotSupportedImage(),
            ),
          ),
          ListTile(
            title: Text(
              astronomicalObject.title ?? "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(astronomicalObject.date ?? ""),
          )
        ],
      ),
    ),
  );
}
