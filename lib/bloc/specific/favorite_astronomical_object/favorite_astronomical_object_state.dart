part of 'favorite_astronomical_object_cubit.dart';

abstract class FavoriteAstronomicalObjectState extends Equatable {
  const FavoriteAstronomicalObjectState();

  @override
  List<Object> get props => [];
}

class FavoriteAstronomicalObjectInitialState
    extends FavoriteAstronomicalObjectState {}

class FavoriteAstronomicalObjectChangeInProgressState
    extends FavoriteAstronomicalObjectState {}

class FavoriteAstronomicalObjectChangeSuccessState
    extends FavoriteAstronomicalObjectState {}

class FavoriteAstronomicalObjectChangeFailureState
    extends FavoriteAstronomicalObjectState {}
