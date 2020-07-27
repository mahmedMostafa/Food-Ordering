import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:res_delivery/features/cart/domain/cart_repository.dart';
import 'package:res_delivery/features/cart/presentation/widgets/cart_item.dart';
import 'package:res_delivery/models/PopularItem.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;

  CartBloc({@required this.cartRepository}) : super(CartInitial());

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    if (event is LoadCart) {
      yield* _mapLoadCartToState();
    } else if (event is UpdateCartAmount) {
      yield* _mapUpdateCartAmountToState(event.item, event.increase);
    } else if (event is GetTotalPrice) {}
  }

  Stream<CartState> _mapLoadCartToState() async* {
    try {
      final result = await cartRepository.getCartItems();
      if (result.isEmpty) {
        yield CartEmpty();
      } else {
        yield CartLoaded(cartItems: result);
      }
    } catch (error) {
      print("Error is $error");
      yield CartFailed();
    }
  }

//
//  @override
//  Future<Function> close() {
//    Hive.close();
//  }
//
  Stream<CartState> _mapUpdateCartAmountToState(
      PopularItem item, bool increase) async* {
    cartRepository.updateCartAmount(item, increase);
  }
}
