import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:res_delivery/features/home/providers/popular_items_provider.dart';
import 'package:res_delivery/features/home/widgets/section_label.dart';
import 'package:res_delivery/features/items/items_screen.dart';
import 'package:res_delivery/shared/foodItem.dart';
import 'package:res_delivery/utils/connection_status.dart';

class PopularItems extends StatefulWidget {
  @override
  _PopularItemsState createState() => _PopularItemsState();
}

class _PopularItemsState extends State<PopularItems> {
  Future getPopularItems;
  var isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isLoaded) {
      getPopularItems =
          Provider.of<PopularItemsProvider>(context, listen: false)
              .getPopularItems();
      isLoaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Build is Called");
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SectionLabel("Popular items"),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: FlatButton(
                textColor: Theme.of(context).accentColor,
                child: Text("See All"),
                onPressed: () => Navigator.of(context)
                    .pushNamed(ItemsScreen.routeName, arguments: "chicken"),
              ),
            )
          ],
        ),
        FutureBuilder(
          future: getPopularItems,
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (dataSnapshot.error != null) {
                //TODO some error handling
                return Text("something went wrong");
              } else {
                return Consumer<PopularItemsProvider>(
                  builder: (ctx, data, child) {
                    final items = data.popularItems;
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: items.isEmpty ? 0 : items.length,
                      itemBuilder: (ctx, index) => FoodItem(
                        item: items[index],
                      ),
                    );
                  },
                );
              }
            }
          },
        )
      ],
    );
  }
}
