import 'package:bloc/bloc.dart';
import 'package:codetomobile/shared/logger/simple_bloc_observer.dart';
import 'package:codetomobile/ui/screens/astronomical_object_list.dart';
import 'package:flutter/material.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Genetic algorithms',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AstronomicalObjectList(),
    );
  }
}
