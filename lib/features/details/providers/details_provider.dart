import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:res_delivery/databases/cart_database.dart';
import 'package:res_delivery/models/PopularItem.dart';
import 'package:res_delivery/utils/constants.dart';
import 'package:http/http.dart' as http;

class DetailsProvider extends ChangeNotifier {
  PopularItem _item = PopularItem();

  PopularItem get item => _item;
  List<String> _ingredients = [];

  List<String> get ingredients => [..._ingredients];

  Future<void> getItemDetails(String id) async {
    final queryParams = {'rId': id};
    final url = Uri.https(BASE_URL, "/api/get", queryParams);
    final response = await http.get(url);
    final json = jsonDecode(response.body);
    _item = PopularItem.fromJSON(json['recipe']);
    // we are certain it's a list of strings
    _ingredients = _item.ingredients.cast<String>().toList();
    print("Item is ${_ingredients.toString()}");
    notifyListeners();
  }

  Future<void> addToCart(PopularItem item) async {
    await CartDatabase.insert(item);
    print("Done adding to cart");
  }
}
