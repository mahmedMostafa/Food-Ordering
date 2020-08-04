part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeStarted extends HomeEvent {}

class LoadImageSlider extends HomeEvent {}

class LoadMealTypes extends HomeEvent {}

class LoadPopulatItems extends HomeEvent {}
