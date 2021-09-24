import 'package:codetomobile/bloc/specific/router/router_bloc.dart';
import 'package:codetomobile/data/models/astronomical_object.dart';
import 'package:codetomobile/shared/view/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
          _buildAppBar(),
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

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 300.0,
      floating: true,
      pinned: true,
      snap: true,
      actions: [
        IconButton(
          icon: Icon(Icons.favorite_border_outlined),
          onPressed: () {},
          color: Colors.white,
        )
      ],
      actionsIconTheme: IconThemeData(opacity: 0.0),
      flexibleSpace: Stack(
        children: <Widget>[
          FlexibleSpaceBar(
            stretchModes: [StretchMode.zoomBackground],
            collapseMode: CollapseMode.parallax,
            background: Image.network(
              args.astronomicalObject.hdurl ?? "",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            right: 0.0,
            top: 0.0,
            child: SafeArea(
              child: IconButton(
                icon: Icon(Icons.favorite_border_outlined),
                onPressed: () {},
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

// FlexibleSpaceBar(
//         stretchModes: [StretchMode.zoomBackground],
//         collapseMode: CollapseMode.none,
//         background: Image.network(
//           args.astronomicalObject.hdurl ?? "",
//           fit: BoxFit.cover,
//         ),
//       ),

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
