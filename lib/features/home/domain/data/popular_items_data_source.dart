import 'package:http/http.dart' as http;
import 'package:res_delivery/models/PopularItem.dart';
import 'package:res_delivery/utils/constants.dart';
import 'dart:convert';

class PopularItemsDataSource {
  //simple class to have one function which gives us the list ready
  Future<List<PopularItem>> getPopularItems() async {
    final queryParams = {"q": "bacon"};
    var uri = Uri.https(BASE_URL, "/api/search", queryParams);
    final result = await http.get(uri);
    final json = jsonDecode(result.body);
    final Iterable iterable = json['recipes'];
    return iterable.map((item) => PopularItem.fromJSON(item)).toList();
  }
}
