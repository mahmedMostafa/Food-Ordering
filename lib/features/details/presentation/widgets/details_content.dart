import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_delivery/features/details/bloc/details_bloc.dart';
import 'package:res_delivery/models/PopularItem.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../details_argument.dart';
import 'add_to_cart.dart';
import 'details_discount.dart';
import 'details_ingredients.dart';
import 'details_rating_reviews.dart';
import 'details_title_text.dart';

class DetailsContent extends StatelessWidget {
  final DetailsArgument args;

  const DetailsContent({Key key, this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        TitleText(
          title: args.title,
        ),
        DetailsRatingReviews(
          rating: args.rating,
          numOfReviews: args.numOfReviews,
        ),
        DetailsPrice(price: args.price),
        DetailsIngredients(),
        AddToCartWidget(
          popularItem: PopularItem(
            id: args.id,
            title: args.title,
            imageUrl: args.imageUrl,
            price: args.price,
          ),
        )
      ]),
    );
  }
}
