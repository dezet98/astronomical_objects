import 'package:codetomobile/bloc/specific/fetch_astronomical_objects_bloc.dart';
import 'package:codetomobile/data/models/astronomical_object.dart';
import 'package:codetomobile/shared/extension.dart';
import 'package:codetomobile/shared/logger/app_logger.dart';
import 'package:codetomobile/shared/view/dimensions.dart';
import 'package:codetomobile/ui/components/bloc_builders/fetch_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class AstronomicalObjectList extends StatelessWidget {
  const AstronomicalObjectList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Colors.blue,
          title: Text('Astronomy Picture of the Day'),
          floating: true,
          pinned: true,
        ),
        FetchBlocBuilder(
          isSliver: true,
          fetchBloc: context.bloc<FetchAtronomicalObjectsBloc>(),
          buildSuccess: (dynamic data, bool isRefresh) {
            return _buildGrid(context, data);
          },
        )
      ]),
    );
  }
}

Widget _buildGrid(
    BuildContext context, List<AstronomicalObject> astronomicalObjects) {
  return SliverPadding(
    padding: EdgeInsets.all(Dimensions.small),
    sliver: SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return _buildCard(context, astronomicalObjects[index]);
        },
        childCount: astronomicalObjects.length,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: Dimensions.small,
        crossAxisSpacing: Dimensions.small,
        childAspectRatio: 0.75,
      ),
    ),
  );
}

Widget _buildCard(BuildContext context, AstronomicalObject astronomicalObject) {
  return Card(
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

              return Text('😢');
            },
          ),
        ),
        ListTile(
          title: Text(astronomicalObject.title ?? ""),
          subtitle: Text(astronomicalObject.date ?? ""),
        )
      ],
    ),
  );
}
