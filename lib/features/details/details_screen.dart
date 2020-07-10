import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:res_delivery/features/details/details_argument.dart';
import 'package:res_delivery/models/PopularItem.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'providers/details_provider.dart';

class DetailsScreen extends StatefulWidget {
  static const routeName = "/details_screen_route";

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Future itemDetails;
  var isLoaded = false;
  DetailsArgument args;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isLoaded) {
      args = ModalRoute.of(context).settings.arguments;
      itemDetails =
          Provider.of<DetailsProvider>(context).getItemDetails(args.id);
      isLoaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 350,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image(
                image: NetworkImage(args.imageUrl),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.only(
                    left: 12.0, right: 12.0, top: 6, bottom: 6),
                child: Text(
                  args.title,
                  style: Theme.of(context)
                      .textTheme
                      .headline
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 12.0, right: 12.0, top: 6, bottom: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SmoothStarRating(
                      borderColor: Theme.of(context).accentColor,
                      rating: args.rating,
                      color: Theme.of(context).accentColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      args.rating.toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text("(${args.numOfReviews} Reviews)")
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 12.0, right: 12.0, top: 6, bottom: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Served in lunch, breakfast and dinner",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "\$${args.price}",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 12.0, right: 12.0, top: 6, bottom: 6),
                child: FutureBuilder(
                  future: itemDetails,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Text("Loading ingredients..."),
                      );
                    } else {
                      if (snapshot.error != null) {
                        return Center(
                          child: Text(
                              "Something went wrong\n couldn't load ingredients"),
                        );
                      } else {
                        return Consumer<DetailsProvider>(
                            builder: (context, detailsData, child) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: detailsData.ingredients.map((item) {
                              return Text(
                                item.toString(),
                                style: TextStyle(
                                    fontSize: 18, color: Colors.grey[800]),
                              );
                            }).toList(),
                          );
                        });
                      }
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Provider.of<DetailsProvider>(context,listen: false).addToCart(
                        PopularItem(
                          id: args.id,
                          title: args.title,
                          imageUrl: args.imageUrl,
                          price: args.price,
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: const Text(
                          "Order Now",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
