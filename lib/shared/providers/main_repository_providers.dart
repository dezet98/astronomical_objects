import 'package:codetomobile/data/rest_client/rest_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<RepositoryProvider> getMainRepositoryProviders() => [
      RepositoryProvider<RestClient>(
        create: (_) =>
            RestClient((Dio(BaseOptions(contentType: "application/json")))),
      ),
    ];
