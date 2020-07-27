import 'package:res_delivery/databases/cart_database.dart';
import 'package:res_delivery/models/PopularItem.dart';

class CartDataSource {
  Future<List<PopularItem>> getCartItems() async {
    final database = await CartDatabase.getCart();
    return database.map((item) => PopularItem.fromMap(item)).toList();
  }

  Future<void> updateCartAmount(PopularItem item, bool increase) async {
    await CartDatabase.updateAmount(item, increase);
  }
}
