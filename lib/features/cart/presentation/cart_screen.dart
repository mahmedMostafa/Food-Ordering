import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_delivery/features/cart/bloc/cart_bloc.dart';
import 'package:res_delivery/features/cart/data/cart_data_source.dart';
import 'package:res_delivery/features/cart/domain/cart_repository.dart';
import 'widgets/cart_list.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "/cart_route_name";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: BlocProvider(
        create: (BuildContext context) => CartBloc(
          cartRepository: CartRepository(
            cartDataSource: CartDataSource(),
          ),
        )..add(LoadCart()),
        child: Cart(),
      ),
    );
  }
}

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      buildWhen: (previous, current) => current is CartItems,
      listener: (BuildContext context, CartState state) {},
      builder: (BuildContext context, CartState state) {
        if (state is CartLoaded) {
          BlocProvider.of<CartBloc>(context);
          return CartListItems(state: state);
        } else if (state is CartFailed) {
          return Center(
            child: Text("Failed to load cart"),
          );
        } else if (state is CartEmpty) {
          return Center(
            child: Text("Your Cart is empty"),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
