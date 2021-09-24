import 'package:codetomobile/bloc/abstract/fetch/fetch_bloc.dart';
import 'package:codetomobile/bloc/specific/fetch_astronomical_objects_bloc.dart';
import 'package:codetomobile/data/models/astronomical_object.dart';
import 'package:codetomobile/shared/extension.dart';
import 'package:codetomobile/shared/logger/app_logger.dart';
import 'package:codetomobile/shared/view/dimensions.dart';
import 'package:codetomobile/ui/components/bloc_builders/fetch_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AstronomicalObjectList extends StatelessWidget {
  const AstronomicalObjectList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: Theme.of(context).backgroundColor,
      body: RefreshIndicator(
        onRefresh: () async => await _onRefresh(context),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(toolbarHeight: 0.0),
            FetchBlocBuilder(
              isSliver: true,
              fetchBloc: context.bloc<FetchAtronomicalObjectsBloc>(),
              buildSuccess: (dynamic data, bool isRefresh) {
                return _buildGrid(context, data);
              },
            )
          ],
        ),
      ),
    );
  }
}

AppBar _buildAppBar(BuildContext context) {
  return AppBar(
    title: Text(
      AppLocalizations.of(context)!.astronomical_object_list_app_bar_title,
    ),
    backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
  );
}

Future<void> _onRefresh(BuildContext context) async {
  context.bloc<FetchAtronomicalObjectsBloc>().add(FetchRefreshEvent());

  await Future.doWhile(
      () => !context.bloc<FetchAtronomicalObjectsBloc>().fetchComplete);
}

Widget _buildGrid(
    BuildContext context, List<AstronomicalObject> astronomicalObjects) {
  return SliverPadding(
    padding: EdgeInsets.all(Dimensions.verySmall),
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
        crossAxisSpacing: Dimensions.verySmall,
        childAspectRatio: 0.75,
      ),
    ),
  );
}

Widget _buildCard(BuildContext context, AstronomicalObject astronomicalObject) {
  return Card(
    clipBehavior: Clip.antiAlias,
    elevation: 0.0,
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
          title: Text(
            astronomicalObject.title ?? "",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(astronomicalObject.date ?? ""),
        )
      ],
    ),
  );
}
