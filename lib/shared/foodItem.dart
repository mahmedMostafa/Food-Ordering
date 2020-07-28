import 'package:flutter/material.dart';
import 'package:res_delivery/features/details/details_argument.dart';
import 'package:res_delivery/features/details/presentation/details_screen.dart';
import 'package:res_delivery/models/PopularItem.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class FoodItem extends StatelessWidget {
  final PopularItem item;

  const FoodItem({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          //this is not usually the case since we only send the id
          //but here we generate the price and rating randomly so we send them all
          Navigator.of(context).pushNamed(DetailsScreen.routeName,
              arguments: DetailsArgument(
                id: item.id,
                imageUrl: item.imageUrl,
                title: item.title,
                numOfReviews: item.numOfReviews,
                price: item.price,
                rating: item.rating,
                likes: item.likes,
              ));
        },
        child: Container(
          margin: EdgeInsets.all(4),
          height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(.32),
                    offset: Offset(0, 4),
                    blurRadius: 20)
              ]),
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
                      image: NetworkImage(item.imageUrl),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width - 140,
                    // this is just a workaround b/c i can't control the overflow
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      item.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        SmoothStarRating(
                          size: 16,
                          isReadOnly: true,
                          rating: item.rating,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          item.rating.toString(),
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          "(${item.numOfReviews} Reviews)",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 140,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                          child: Text(
                            "${item.likes} Likes",
                            style: TextStyle(
                                color: Colors.grey[700], fontSize: 12),
                          ),
                        ),
                        Text(
                          "\$${item.likes}",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
