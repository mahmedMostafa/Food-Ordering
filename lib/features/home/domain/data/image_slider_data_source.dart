class ImageSliderItem {
  final String id;
  final String title;
  final String imageUrl;

  ImageSliderItem({this.id, this.title, this.imageUrl});
}

/*
    fake data source to be easier to change later
 */
class ImageSliderDataSource {
  final List<ImageSliderItem> _sliders = [
    ImageSliderItem(
        id: "Pizza",
        title: 'Italian Pizza with cheese',
        imageUrl: 'assets/images/pizza.png'),
    ImageSliderItem(
        id: "Burger",
        title: 'Cheese burgers with steaks',
        imageUrl: 'assets/images/burger.png'),
    ImageSliderItem(
        id: "Pasta",
        title: 'Pasta with meat balls',
        imageUrl: 'assets/images/pasta.png'),
    ImageSliderItem(
        id: "Donuts",
        title: 'Delicious sweet donuts',
        imageUrl: 'assets/images/donats.png'),
  ];

  Future<List<ImageSliderItem>> getImageSlider() async {
    //simulate a network delay
    await Future.delayed(Duration(milliseconds: 1));
    return _sliders;
  }
}
