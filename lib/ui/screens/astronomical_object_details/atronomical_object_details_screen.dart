import 'package:codetomobile/bloc/specific/router/router_bloc.dart';
import 'package:codetomobile/data/models/astronomical_object.dart';
import 'package:codetomobile/shared/extension.dart';
import 'package:codetomobile/shared/routes.dart';
import 'package:codetomobile/ui/components/specific/heart_builder.dart';
import 'package:codetomobile/ui/screens/photo_view/photo_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'astronomical_object_details_content.dart';

class AtronomicalObjectDetailsArgs extends RouteArgs {
  final AstronomicalObject astronomicalObject;

  AtronomicalObjectDetailsArgs({required this.astronomicalObject});
}

class AtronomicalObjectDetailsScreen extends StatelessWidget {
  final AtronomicalObjectDetailsArgs args;

  const AtronomicalObjectDetailsScreen({required this.args, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool _) {
          return [
            _buildAppBar(context),
          ];
        },
        body: buildContent(context, args.astronomicalObject),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300.0,
      floating: true,
      backgroundColor: Colors.transparent,
      actionsIconTheme: const IconThemeData(opacity: 0.0),
      flexibleSpace: Stack(
        children: <Widget>[
          FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            background: Image.network(
              args.astronomicalObject.url ?? "",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            right: 0.0,
            top: 0.0,
            child: SafeArea(
              child: Row(
                children: [
                  _buildShowPhoto(context, args.astronomicalObject),
                  HeartBuilder(args.astronomicalObject),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShowPhoto(
      BuildContext context, AstronomicalObject astronomicalObject) {
    String url = astronomicalObject.hdurl ??
        astronomicalObject.url ??
        astronomicalObject.thumbnailUrl ??
        "";

    return IconButton(
      icon: const Icon(
        Icons.remove_red_eye_outlined,
        color: Colors.white,
      ),
      onPressed: () => _routeToPhotoScreen(context, url),
    );
  }

  void _routeToPhotoScreen(BuildContext context, String url) {
    context.bloc<RouterBloc>().add(
          RouterNavigateToEvent(
            RouteName.PHOTO_VIEW_SCREEN,
            routeArgs: PhotoViewScreenArgs(
              imageUrl: url,
            ),
          ),
        );
  }
}
