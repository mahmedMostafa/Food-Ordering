import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class DetailsRatingReviews extends StatelessWidget {
  final double rating;
  final int numOfReviews;

  const DetailsRatingReviews({Key key, this.rating, this.numOfReviews})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 12.0, right: 12.0, top: 6, bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SmoothStarRating(
            borderColor: Theme.of(context).accentColor,
            rating: rating,
            color: Theme.of(context).accentColor,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            rating.toString(),
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(
            width: 16,
          ),
          Text("($numOfReviews Reviews)")
        ],
      ),
    );
  }
}
