import 'package:flutter/cupertino.dart';
import 'package:res_delivery/databases/cart_database.dart';
import 'package:res_delivery/models/PopularItem.dart';

class CartProvider extends ChangeNotifier {
  List<PopularItem> _items = [];

  List<PopularItem> get items => _items;

  double _totalCost = 0.0;

  double get totalCost => _totalCost;

  Future<void> getCartItems() async {
    final database = await CartDatabase.getCart();
    _items = database.map((item) => PopularItem.fromMap(item)).toList();

    notifyListeners();
  }

  void getTotalCost() {
    if (_items.length > 0) {
      _items.forEach((item) {
        _totalCost += item.price * item.amount;
      });
    }
    notifyListeners();
  }

  Future<void> updateCartAmount(PopularItem item, bool increase) async {
    _totalCost += item.price;
    notifyListeners();
    await CartDatabase.updateAmount(item, increase);
    //TODO i don't know yet if i should call notifylisetners and for what
  }
}
