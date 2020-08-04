import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_delivery/features/cart/bloc/cart_bloc.dart';

import 'cart_item.dart';

class CartListItems extends StatefulWidget {
  final CartLoaded state;

  const CartListItems({Key key, this.state}) : super(key: key);

  @override
  _CartListItemsState createState() => _CartListItemsState();
}

class _CartListItemsState extends State<CartListItems> {

  double totalPrice =0;

  @override
  void initState() {
    super.initState();
    totalPrice = widget.state.totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    print("build called");
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              print(widget.state.cartItems.toString());
              return CartItem(
                item: widget.state.cartItems[index],
                onPriceChange: (value) {
                  print("Called with value of ${value}");
                  setState(() {
                    totalPrice += value;
                  });
                },
              );
            },
            itemCount: widget.state.cartItems.length,
          ),
        ),
        Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      "Total:",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "\$${totalPrice.toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).accentColor,
                  ),
                  child: Center(
                    child: Text(
                      "Checkout".toUpperCase(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
