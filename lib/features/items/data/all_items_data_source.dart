import 'dart:convert';
import 'package:res_delivery/models/PopularItem.dart';
import 'package:res_delivery/utils/constants.dart';
import 'package:http/http.dart' as http;

class AllItemsDataSource {
  Future<List<PopularItem>> getItems(String query, int pageNumber) async {
    final queryParams = {"q": query, "page": pageNumber.toString()};
    final url = Uri.https(BASE_URL, "/api/search", queryParams);
    print("url is ${url.toString()}");
    final response = await http.get(url);
    final json = jsonDecode(response.body);
    final Iterable iterable = json['recipes'];
    return iterable.map((item) => PopularItem.fromJSON(item)).toList();
  }
}
