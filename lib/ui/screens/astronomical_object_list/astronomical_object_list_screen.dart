import 'package:codetomobile/bloc/abstract/load_data/load_data_bloc.dart';
import 'package:codetomobile/bloc/specific/fetch_astronomical_objects_bloc.dart';
import 'package:codetomobile/shared/extension.dart';
import 'package:codetomobile/ui/components/bloc_builders/load_data_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'astronomical_object_list_app_bar.dart';
import 'astronomical_object_list_builder.dart';

class AstronomicalObjectList extends StatelessWidget {
  const AstronomicalObjectList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: RefreshIndicator(
        onRefresh: () async => await _onRefresh(context),
        child: CustomScrollView(
          slivers: <Widget>[
            const SliverAppBar(toolbarHeight: 0.0),
            LoadDataBlocBuilder(
              isSliver: true,
              loadDataBloc: context.bloc<FetchAtronomicalObjectsBloc>(),
              buildSuccess: (dynamic data, bool isRefresh) {
                return buildGrid(context, data);
              },
            )
          ],
        ),
      ),
    );
  }
}

Future<void> _onRefresh(BuildContext context) async {
  context.bloc<FetchAtronomicalObjectsBloc>().add(LoadDataReloadEvent());

  await Future.delayed(Duration(seconds: 2));
}
