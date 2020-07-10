import 'package:flutter/cupertino.dart';

class ImageSliderItem {
  final String id;
  final String title;
  final String imageUrl;

  ImageSliderItem({this.id, this.title, this.imageUrl});
}

class ImageSliderProvider extends ChangeNotifier {
  final List<ImageSliderItem> _sliders = [
    ImageSliderItem(
        id: "Pizza",
        title: 'Italian Pizza with cheese',
        imageUrl: 'assets/pizza.png'),
    ImageSliderItem(
        id: "Burger",
        title: 'Cheese burgers with steaks',
        imageUrl: 'assets/burger.png'),
    ImageSliderItem(
        id: "Pasta",
        title: 'Pasta with meat balls',
        imageUrl: 'assets/pasta.png'),
    ImageSliderItem(
        id: "Donuts",
        title: 'Delicious sweet donuts',
        imageUrl: 'assets/donats.png'),
  ];

  List<ImageSliderItem> get sliders => _sliders;
}
