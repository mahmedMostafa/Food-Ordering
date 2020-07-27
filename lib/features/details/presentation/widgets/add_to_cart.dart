import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_delivery/features/details/bloc/details_bloc.dart';
import 'package:res_delivery/models/PopularItem.dart';

class AddToCartWidget extends StatelessWidget {
  final PopularItem popularItem;

  const AddToCartWidget({Key key, this.popularItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            BlocProvider.of<DetailsBloc>(context)
                .add(AddToCart(popularItem: popularItem));
          },
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: BlocBuilder<DetailsBloc, DetailsState>(
              buildWhen: (previous, current) => current is AddToCartState,
              builder: (BuildContext context, DetailsState state) {
                if (state is AddToCartLoaded) {
                  return buildCartText("Added To Cart");
                } else if (state is AddToCartFailed) {
                  return buildCartText("Add To Cart");
                } else if (state is AddToCartInProgress) {
                  return Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "Adding to Cart",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
                        child: SizedBox(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                            strokeWidth: 2,
                          ),
                          height: 24,
                          width: 24,
                        ),
                      )
                    ],
                  );
                } else {
                  return buildCartText("Add To Cart");
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Center buildCartText(String text) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
