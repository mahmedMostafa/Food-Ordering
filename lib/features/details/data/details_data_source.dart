import 'dart:convert';

import 'package:res_delivery/databases/cart_database.dart';
import 'package:res_delivery/models/PopularItem.dart';
import 'package:res_delivery/utils/constants.dart';
import 'package:http/http.dart' as http;

class DetailsDataSource {
  
  Future<PopularItem> getItemDetails(String id) async {
    PopularItem _item = PopularItem();
    final queryParams = {'rId': id};
    final url = Uri.https(BASE_URL, "/api/get", queryParams);
    final response = await http.get(url);
    final json = jsonDecode(response.body);
    _item = PopularItem.fromJSON(json['recipe']);
    // we are certain it's a list of strings
    _item.ingredients.cast<String>().toList();
    return _item;
  }

  Future<void> addToCart(PopularItem item) async {
    await CartDatabase.insert(item);
  }
}
