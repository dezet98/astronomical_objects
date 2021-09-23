import 'package:codetomobile/bloc/specific/fetch_astronomical_objects_bloc.dart';
import 'package:codetomobile/data/rest_client/rest_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<BlocProvider> getMainBlocProviders() => [
      BlocProvider<FetchAtronomicalObjectsBloc>(
        create: (context) => FetchAtronomicalObjectsBloc(
            RepositoryProvider.of<RestClient>(context)),
      ),
    ];
