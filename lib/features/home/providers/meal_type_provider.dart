import 'package:flutter/cupertino.dart';

class MealType {
  final String id;
  final String title;
  final String imageUrl;

  MealType({this.id, this.title, this.imageUrl});
}

class MealTypeProvider extends ChangeNotifier {

  final List<MealType> _types = [
    MealType(title: "Breakfast", imageUrl: 'assets/icons/breakfast.svg'),
    MealType(title: "Lunch", imageUrl: 'assets/icons/lunch.svg'),
    MealType(title: "Dinner", imageUrl: 'assets/icons/burger.svg'),
    MealType(title: "Desserts", imageUrl: 'assets/icons/desserts.svg'),
    MealType(title: "Drinks", imageUrl: 'assets/icons/soda.svg'),
  ];

  List<MealType> get foodTypes => [..._types];
}
