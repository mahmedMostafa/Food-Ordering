import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_delivery/features/home/domain/data/image_slider_data_source.dart';
import 'package:res_delivery/features/home/domain/data/meal_type_data_source.dart';
import 'package:res_delivery/features/home/domain/home_repository.dart';
import 'package:res_delivery/models/PopularItem.dart';
part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;

  HomeBloc({@required this.homeRepository}) : super(HomeInitial());

  factory HomeBloc.beginLoadingHome(BuildContext context) =>
      BlocProvider.of<HomeBloc>(context)
        ..add(LoadImageSlider())
        ..add(LoadPopulatItems())
        ..add(LoadPopulatItems());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is LoadImageSlider) {
      yield* _mapLoadImageSliderToState();
    } else if (event is LoadMealTypes) {
      yield* _mapLoadMealTypesToState();
    } else if (event is LoadPopulatItems) {
      yield* _mapLoadPopularItemsToState();
    }
  }

  Stream<HomeState> _mapLoadMealTypesToState() async* {
    yield MealTypeInProgress();
    try {
      List<MealType> data = await homeRepository.getMealTypes();
      yield MealTypeLoaded(mealTypes: data);
    } catch (error) {
      yield MealTypeFailed();
    }
  }

  Stream<HomeState> _mapLoadPopularItemsToState() async* {
    yield PopularItemsInProgress();
    try {
      List<PopularItem> data = await homeRepository.getPopularItems();
      yield PopularItemsLoaded(popularItems: data);
    } catch (error) {
      yield PopularItemsFailed();
    }
  }

  Stream<HomeState> _mapLoadImageSliderToState() async* {
    yield ImageSliderInProgress();
    try {
      List<ImageSliderItem> data = await homeRepository.getImageSlider();
      yield ImageSliderLoaded(imageSlider: data);
    } catch (error) {
      yield ImageSliderFailed();
    }
  }
}
