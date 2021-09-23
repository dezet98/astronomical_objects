import 'package:codetomobile/data/models/astronomical_object.dart';
import 'package:codetomobile/data/rest_client/rest_client.dart';
import 'package:dio/dio.dart';
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
            child: _buildBody(context),
          ),
        ),
      ),
    );
  }
}

FutureBuilder<List<AstronomicalObject>> _buildBody(BuildContext context) {
  final client =
      RestClient((Dio(BaseOptions(contentType: "application/json"))));

  return FutureBuilder<List<AstronomicalObject>>(
    future: client.getAstronomicalObjects(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done &&
          snapshot.hasData &&
          !snapshot.hasError) {
        final List<AstronomicalObject> posts = snapshot.data!;
        return Column(
          children: [
            for (AstronomicalObject i in posts)
              ListTile(title: Text(i.toJson().toString()))
          ],
        );
      } else if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      } else {
        return Center(
          child: Text("Error"),
        );
      }
    },
  );
}
