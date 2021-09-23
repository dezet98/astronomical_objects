import 'package:codetomobile/bloc/specific/fetch_astronomical_objects_bloc.dart';
import 'package:codetomobile/ui/components/bloc_builders/fetch_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AstronomicalObjectList extends StatelessWidget {
  const AstronomicalObjectList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: _buildBloc(context),
          ),
        ),
      ),
    );
  }
}

Widget _buildBloc(BuildContext context) {
  return FetchBlocBuilder(
    fetchBloc: FetchAtronomicalObjectsBloc(),
    buildSuccess: (dynamic data, bool isRefresh) {
      return Text("Work");
    },
  );
}
