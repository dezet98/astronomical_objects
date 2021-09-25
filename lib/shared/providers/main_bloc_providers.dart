import 'package:codetomobile/bloc/specific/fetch_astronomical_objects_bloc.dart';
import 'package:codetomobile/bloc/specific/load_favorites_astronomical_objects_bloc.dart';
import 'package:codetomobile/bloc/specific/router/router_bloc.dart';
import 'package:codetomobile/data/repositories/astronomical_object_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<BlocProvider> getMainBlocProviders() => [
      BlocProvider<RouterBloc>(create: (_) => RouterBloc()),
      BlocProvider<FetchAtronomicalObjectsBloc>(
        create: (context) => FetchAtronomicalObjectsBloc(
            RepositoryProvider.of<AstronomicalObjectRepository>(context)),
      ),
      BlocProvider<LoadFavoritesAtronomicalObjectsBloc>(
        create: (context) => LoadFavoritesAtronomicalObjectsBloc(
            RepositoryProvider.of<AstronomicalObjectRepository>(context)),
      ),
    ];
