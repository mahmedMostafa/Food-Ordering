import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:res_delivery/features/cart/providers/cart_provider.dart';
import 'package:res_delivery/features/cart/widgets/cart_item.dart';
import 'package:res_delivery/utils/constants.dart';

class CartScreen extends StatefulWidget {
  static const routeName = "/cart_screen_route";

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Future getCart;
  var isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isLoaded) {
      isLoaded = true;
      getCart = Provider.of<CartProvider>(context).getCartItems();
    }
  }

  @override
  Widget build(BuildContext context) {
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: FutureBuilder(
        future: getCart,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.error != null) {
              print(snapshot.error.toString());
              return Center(
                child: Text("Something went wrong\nTry again later"),
              );
            } else {
              return Consumer<CartProvider>(
                builder: (context, value, child) {
                  final cart = value.items;
                  final cost = value.totalCost;
                  return SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: height * 0.7,
                          child: ListView.builder(
                            itemBuilder: (ctx, index) {
                              print(cart[index].toString());
                              return CartItem(cart[index]);
                            },
                            itemCount: cart.length,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(color: Colors.white),
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Total:",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        "\$$cost",
                                        style: TextStyle(fontSize: 22),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.05,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 60,
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
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
