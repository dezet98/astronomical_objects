import 'package:codetomobile/bloc/specific/router/router_bloc.dart';
import 'package:codetomobile/data/local_database/local_database_service.dart';
import 'package:codetomobile/data/models/astronomical_object.dart';
import 'package:codetomobile/shared/logger/app_logger.dart';
import 'package:codetomobile/shared/view/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AtronomicalObjectDetailsArgs extends RouteArgs {
  final AstronomicalObject astronomicalObject;

  AtronomicalObjectDetailsArgs({required this.astronomicalObject});
}

class AtronomicalObjectDetails extends StatelessWidget {
  final AtronomicalObjectDetailsArgs args;

  const AtronomicalObjectDetails({required this.args, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.basic,
              vertical: Dimensions.large,
            ),
            sliver: _buildContent(context),
          )
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300.0,
      floating: true,
      pinned: true,
      snap: true,
      actionsIconTheme: IconThemeData(opacity: 0.0),
      flexibleSpace: Stack(
        children: <Widget>[
          FlexibleSpaceBar(
            stretchModes: [StretchMode.zoomBackground],
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
              child: IconButton(
                icon: Icon(Icons.favorite_border_outlined),
                onPressed: () async {
                  var a =
                      await RepositoryProvider.of<LocalDatabaseService>(context)
                          .insertQuery(AstronomicalObject.tableName,
                              args.astronomicalObject.toJson());

                  var x =
                      await RepositoryProvider.of<LocalDatabaseService>(context)
                          .query(AstronomicalObject.tableName);

                  AppLogger()
                      .log(message: x.toString(), logLevel: LogLevel.debug);
                },
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Text(
            args.astronomicalObject.title ?? "",
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: Dimensions.small),
          Text(
            args.astronomicalObject.date ?? "",
            style: Theme.of(context).textTheme.caption,
          ),
          Divider(
            height: Dimensions.huge,
          ),
          Text(
            "About",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(height: Dimensions.small),
          Text(
            args.astronomicalObject.description ?? "",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          Divider(
            height: Dimensions.huge,
          ),
          Text(
            "Website",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(height: Dimensions.small),
          Text(
            args.astronomicalObject.apodSite ?? "",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          Divider(
            height: Dimensions.huge,
          ),
          Text(
            "Authors",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(height: Dimensions.small),
          Text(
            args.astronomicalObject.copyright ?? "",
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
