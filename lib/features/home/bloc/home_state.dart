part of 'home_bloc.dart';

/*
    since these widgets are not that complex
    so we gathered all the states in one general bloc for the whole home page
    and then we can use the buildWhen build function to rebuild the builder only when the state matches our needs
 */
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

/*
    Image Slider states
 */
class ImageSliderState extends HomeState {}

class ImageSliderLoaded extends ImageSliderState {
  final List<ImageSliderItem> imageSlider;

  ImageSliderLoaded({@required this.imageSlider});

  @override
  List<Object> get props => [imageSlider];
}

class ImageSliderFailed extends ImageSliderState {}

class ImageSliderInProgress extends ImageSliderState {}

/*
    Meal Type states
 */
class MealTypeState extends HomeState {}

class MealTypeLoaded extends MealTypeState {
  final List<MealType> mealTypes;

  MealTypeLoaded({@required this.mealTypes});

  @override
  List<Object> get props => [mealTypes];
}

class MealTypeFailed extends MealTypeState {}

class MealTypeInProgress extends MealTypeState {}

/*
    Popular Items states
 */
class PopularItemsState extends HomeState {}

class PopularItemsLoaded extends PopularItemsState {
  final List<PopularItem> popularItems;

  PopularItemsLoaded({@required this.popularItems});

  @override
  List<Object> get props => [popularItems];
}

class PopularItemsFailed extends PopularItemsState {}

class PopularItemsInProgress extends PopularItemsState {}
