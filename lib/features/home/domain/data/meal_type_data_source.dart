class MealType {
  final String id;
  final String title;
  final String imageUrl;

  MealType({this.id, this.title, this.imageUrl});
}

/*
    fake data source to represent the meal type (if we wanted to get meal types from somewhere else only this class gets changed nothing else)
 */
class MealTypeDataSource {
  final List<MealType> _types = [
    MealType(title: "Breakfast", imageUrl: 'assets/icons/breakfast.svg'),
    MealType(title: "Lunch", imageUrl: 'assets/icons/lunch.svg'),
    MealType(title: "Dinner", imageUrl: 'assets/icons/burger.svg'),
    MealType(title: "Desserts", imageUrl: 'assets/icons/desserts.svg'),
    MealType(title: "Drinks", imageUrl: 'assets/icons/soda.svg'),
  ];

  Future<List<MealType>> getMealTypes() async {
    //simulate a network delay
    await Future.delayed(Duration(seconds: 1));
    return _types;
  }
}
