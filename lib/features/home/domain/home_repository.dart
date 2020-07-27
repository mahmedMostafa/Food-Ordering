import 'package:flutter/foundation.dart';
import 'package:res_delivery/features/home/domain/data/image_slider_data_source.dart';
import 'package:res_delivery/features/home/domain/data/meal_type_data_source.dart';
import 'package:res_delivery/features/home/domain/data/popular_items_data_source.dart';
import 'package:res_delivery/models/PopularItem.dart';

class HomeRepository {
  final PopularItemsDataSource popularItemsDataSource;
  final ImageSliderDataSource imageSliderDataSource;
  final MealTypeDataSource mealTypeDataSource;

  HomeRepository({
    @required this.popularItemsDataSource,
    @required this.imageSliderDataSource,
    @required this.mealTypeDataSource,
  });

  Future<List<PopularItem>> getPopularItems() =>
      popularItemsDataSource.getPopularItems();

  Future<List<ImageSliderItem>> getImageSlider() =>
      imageSliderDataSource.getImageSlider();

  Future<List<MealType>> getMealTypes() => mealTypeDataSource.getMealTypes();
}
