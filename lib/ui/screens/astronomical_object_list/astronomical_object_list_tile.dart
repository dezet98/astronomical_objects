import 'package:codetomobile/bloc/specific/router/router_bloc.dart';
import 'package:codetomobile/data/models/astronomical_object.dart';
import 'package:codetomobile/shared/extension.dart';
import 'package:codetomobile/shared/logger/app_logger.dart';
import 'package:codetomobile/shared/routes.dart';
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
            child: Image.network(
              astronomicalObject.url ?? "",
              fit: BoxFit.cover,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                AppLogger().log(
                    message:
                        "Error when loading ${astronomicalObject.url}\n$stackTrace",
                    logLevel: LogLevel.error);

                return const Text('😢');
              },
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
