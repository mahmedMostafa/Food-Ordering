import 'package:flutter/material.dart';
import 'package:res_delivery/features/cart/presentation/cart_screen.dart';

class DetailsAppBar extends StatelessWidget {
  const DetailsAppBar({
    Key key,
    @required this.imageUrl,
    @required this.id,
  }) : super(key: key);

  final String id;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 350,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Image(
          image: NetworkImage(imageUrl),
          fit: BoxFit.fill,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () =>
              Navigator.of(context).pushNamed(CartScreen.routeName),
        )
      ],
    );
  }
}
