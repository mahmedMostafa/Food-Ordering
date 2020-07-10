import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:res_delivery/models/PopularItem.dart';
import 'package:res_delivery/utils/constants.dart';
import 'package:http/http.dart' as http;

class ItemsProvider extends ChangeNotifier {
  List<PopularItem> _items = [];

  List<PopularItem> get items => [..._items];

  Future<void> getItems(String query) async {
    final queryParams = {"q": query};
    final url = Uri.https(BASE_URL, "/api/search", queryParams);
    final response = await http.get(url);
    final json = jsonDecode(response.body);
    final Iterable iterable = json['recipes'];
    _items = iterable.map((item) => PopularItem.fromJSON(item)).toList();
    print("first item is ${_items[0].title}");
    notifyListeners();
  }
}
