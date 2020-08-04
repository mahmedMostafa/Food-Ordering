import 'package:flutter/foundation.dart';
import 'package:res_delivery/features/items/data/all_items_data_source.dart';
import 'package:res_delivery/models/PopularItem.dart';

class AllItemsRepository {
  final AllItemsDataSource allItemsDataSource;

  AllItemsRepository({@required this.allItemsDataSource});

  Future<List<PopularItem>> getAllItems(String query, int pageNumber) =>
      allItemsDataSource.getItems(query, pageNumber);
}
