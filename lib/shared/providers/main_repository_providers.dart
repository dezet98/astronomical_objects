import 'package:codetomobile/data/local_database/local_database.dart';
import 'package:codetomobile/data/models/astronomical_object.dart';
import 'package:codetomobile/data/repositories/astronomical_object_repository.dart';
import 'package:codetomobile/data/rest_client/rest_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<RepositoryProvider> getMainRepositoryProviders() => [
      RepositoryProvider<RestClient>(
        create: (_) =>
            RestClient((Dio(BaseOptions(contentType: "application/json")))),
      ),
      RepositoryProvider<LocalDatabase>(
          create: (_) => LocalDatabase(
                "daniel_app_database",
                3,
                [AstronomicalObject.getDatabaseObject()],
              )),
      RepositoryProvider<AstronomicalObjectRepository>(
        create: (context) => AstronomicalObjectRepository(
          RepositoryProvider.of<RestClient>(context),
          RepositoryProvider.of<LocalDatabase>(context),
        ),
      )
    ];
