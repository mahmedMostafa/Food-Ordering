part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartItems extends CartState {}

class CartLoaded extends CartItems {
  final List<PopularItem> cartItems;
  double _totalPrice = 0;

  CartLoaded({@required this.cartItems}) {
    _totalPrice = cartItems.fold(
        0, (total, current) => total + (current.price * current.amount));
  }

  double get totalPrice => _totalPrice;

  @override
  List<Object> get props => [cartItems];
}

class CartEmpty extends CartItems {}

class CartFailed extends CartItems {}

class CartTotalPrice extends CartLoaded {
  double totalPrice;
  final List<PopularItem> cartItems;

  CartTotalPrice({this.totalPrice, this.cartItems});

  CartTotalPrice copyWith({double price, bool increase}) {
    final newPrice =
        increase ? this.totalPrice += price : this.totalPrice -= price;
    return CartTotalPrice(totalPrice: newPrice ?? this.totalPrice);
  }

  @override
  List<Object> get props => [totalPrice];
}
