import 'package:codetomobile/data/local_database/local_database_service.dart';
import 'package:codetomobile/data/models/astronomical_object.dart';
import 'package:codetomobile/data/rest_client/rest_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<RepositoryProvider> getMainRepositoryProviders() => [
      RepositoryProvider<RestClient>(
        create: (_) =>
            RestClient((Dio(BaseOptions(contentType: "application/json")))),
      ),
      RepositoryProvider<LocalDatabaseService>(
          create: (_) => LocalDatabaseService(
                "daniel_app_database",
                2,
                [AstronomicalObject.getDatabaseObject()],
              ))
    ];
