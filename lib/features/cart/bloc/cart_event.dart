part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCart extends CartEvent {}

class GetTotalPrice extends CartEvent {
  final List<PopularItem> items;

  GetTotalPrice(this.items);

  @override
  List<Object> get props => [items];
}

class UpdateCartAmount extends CartEvent {
  final PopularItem item;
  final bool increase;

  UpdateCartAmount({@required this.item, this.increase});

  @override
  List<Object> get props => [item, increase];
}
