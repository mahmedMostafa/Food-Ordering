import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_delivery/features/cart/bloc/cart_bloc.dart';
import 'package:res_delivery/models/PopularItem.dart';

class CartItem extends StatefulWidget {
  final PopularItem item;

  Function(double price) onPriceChange;

  CartItem({this.item, this.onPriceChange});

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(.32),
                  offset: Offset(0, 4),
                  blurRadius: 20,
                )
              ],
            ),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                        topRight: Radius.circular(4),
                        bottomRight: Radius.circular(4),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(widget.item.imageUrl),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 2,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 140,
                      // this is just a workaround b/c i can't control the overflow
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 2),
                      child: Text(
                        widget.item.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        "\$${(widget.item.price * widget.item.amount).toStringAsFixed(2)}",
                        style: TextStyle(
                            fontSize: 18, color: Theme.of(context).accentColor),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          amountButton(Icons.add, true),
                          SizedBox(
                            width: 8,
                          ),
                          Text("${widget.item.amount}"),
                          SizedBox(
                            width: 8,
                          ),
                          amountButton(Icons.remove, false),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget amountButton(IconData icon, bool increase) {
    return SizedBox(
      height: 30,
      width: 30,
      child: OutlineButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        padding: EdgeInsets.zero,
        onPressed: () {
          final amount = widget.item.amount;
          double changedPrice = 0;
          setState(() {
            if (increase) {
              if (amount < 10) {
                widget.item.amount++;
                changedPrice = widget.item.price;
                BlocProvider.of<CartBloc>(context)
                    .add(UpdateCartAmount(item: widget.item, increase: true));
              }
            } else {
              if (amount > 1) {
                widget.item.amount--;
                changedPrice = widget.item.price * -1;
                BlocProvider.of<CartBloc>(context)
                    .add(UpdateCartAmount(item: widget.item, increase: false));
              }
            }
          });
          widget.onPriceChange(changedPrice);
        },
        child: Center(child: Icon(icon)),
      ),
    );
  }
}
