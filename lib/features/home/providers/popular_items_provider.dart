import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:res_delivery/models/PopularItem.dart';
import 'package:res_delivery/utils/constants.dart';
import 'package:http/http.dart' as http;

class PopularItemsProvider extends ChangeNotifier {
  List<PopularItem> _items = [];

  List<PopularItem> get popularItems => [..._items];

  //TODO handle errors
  Future<void> getPopularItems() async {
    final queryParams = {"q": "bacon"};
    var uri = Uri.https(BASE_URL, "/api/search", queryParams);
    final result = await http.get(uri);
    final json = jsonDecode(result.body);
    final Iterable iterable = json['recipes'];
    _items = iterable.map((item) => PopularItem.fromJSON(item)).toList();
    notifyListeners();
  }
}
