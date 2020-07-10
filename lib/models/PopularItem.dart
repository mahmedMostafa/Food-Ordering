import 'package:res_delivery/utils/constants.dart';

class PopularItem {
  final String id;
  final String imageUrl;
  final String title;
  final double rating;
  final int numOfReviews;
  final int likes;
  int amount;
  final double price;
  List<dynamic> ingredients = [];

  PopularItem({
    this.id,
    this.imageUrl,
    this.title,
    this.rating = 0,
    this.numOfReviews = 0,
    this.likes = 0,
    this.price = 0,
    this.amount = 1,
    this.ingredients,
  });

  /*
    these are just some helper functions for network and database interactions
   */
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'price': price * amount,
      'image': imageUrl,
      'id': id,
      'amount': amount,
    };
  }

  factory PopularItem.fromMap(Map<String, dynamic> data) {
    return PopularItem(
        title: data['title'],
        imageUrl: data['image'],
        id: data['id'],
        price: data['price'],
        amount: data['amount']);
  }

  factory PopularItem.fromJSON(Map<String, dynamic> json) {
    //we just make random representations of what we can't receive from the api
    return PopularItem(
        id: json["recipe_id"],
        imageUrl: json["image_url"],
        title: json["title"],
        rating: num.parse(doubleInRange(3, 5).toStringAsFixed(1)).toDouble(),
        likes: numberInRange(10, 100),
        numOfReviews: numberInRange(100, 500),
        price: num.parse(doubleInRange(20, 100).toStringAsFixed(2)).toDouble(),
        ingredients: json['ingredients'] ?? []);
  }
}
