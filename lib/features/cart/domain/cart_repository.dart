import 'package:flutter/foundation.dart';
import 'package:res_delivery/features/cart/data/cart_data_source.dart';
import 'package:res_delivery/models/PopularItem.dart';

class CartRepository {
  final CartDataSource cartDataSource;

  CartRepository({@required this.cartDataSource});

  Future<List<PopularItem>> getCartItems() => cartDataSource.getCartItems();

//  Future<void> openDataBase() => cartDataSource.openDataBase();

  Future<void> updateCartAmount(PopularItem item, bool increase) =>
      cartDataSource.updateCartAmount(item, increase);
}
