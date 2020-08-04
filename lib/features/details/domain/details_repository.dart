import 'package:flutter/foundation.dart';
import 'package:res_delivery/features/details/data/details_data_source.dart';
import 'package:res_delivery/models/PopularItem.dart';

class DetailsRepository {
  final DetailsDataSource detailsDataSource;

  DetailsRepository({@required this.detailsDataSource});

  Future<PopularItem> getDetails(String id) =>
      detailsDataSource.getItemDetails(id);

  Future<void> addToCart(PopularItem popularItem) =>
      detailsDataSource.addToCart(popularItem);
}
