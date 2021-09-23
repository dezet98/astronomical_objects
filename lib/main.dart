import 'package:bloc/bloc.dart';
import 'package:codetomobile/shared/logger/simple_bloc_observer.dart';
import 'package:codetomobile/shared/providers/main_bloc_providers.dart';
import 'package:codetomobile/shared/providers/main_repository_providers.dart';
import 'package:codetomobile/ui/screens/astronomical_object_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: getMainRepositoryProviders(),
      child: MultiBlocProvider(
        providers: getMainBlocProviders(),
        child: MaterialApp(
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.title,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: AstronomicalObjectList(),
        ),
      ),
    );
  }
}
