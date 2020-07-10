import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:res_delivery/features/home/providers/items_provider.dart';
import 'package:res_delivery/shared/foodItem.dart';

class ItemsScreen extends StatefulWidget {
  static const routeName = "/item_screen_route";

  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  var isLoaded = false;
  Future getItems;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isLoaded) {
      isLoaded = true;
      final query = ModalRoute.of(context).settings.arguments as String;
      getItems = Provider.of<ItemsProvider>(context).getItems(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Popular Items"),
      ),
      body:  FutureBuilder(
          future: getItems,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.error != null) {
                return Center(
                  child: Text("Something went wrong"),
                );
              } else {
                return Consumer<ItemsProvider>(
                  builder: (context, itemsData, child) {
                    final items = itemsData.items;
                    if (items.isEmpty) {
                      return Center(
                        child: Text("Something went wrong"),
                      );
                    } else {
                      return ListView.builder(
                        itemBuilder: (ctx, index) {
                          return FoodItem(item: items[index]);
                        },
                        itemCount: items.length,
                      );
                    }
                  },
                );
              }
            }
          },
        ),
    );
  }
}
