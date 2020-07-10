import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:res_delivery/features/auth/screens/login_screen.dart';
import 'package:res_delivery/features/cart/screens/cart_screen.dart';
import 'package:res_delivery/features/home/providers/image_slider_provider.dart';
import 'package:res_delivery/features/home/providers/items_provider.dart';
import 'package:res_delivery/features/home/providers/meal_type_provider.dart';
import 'package:res_delivery/features/home/providers/popular_items_provider.dart';
import 'package:res_delivery/features/home/widgets/food_types.dart';
import 'package:res_delivery/features/home/widgets/image_slider.dart';
import 'package:res_delivery/features/home/widgets/popular_items.dart';
import 'package:res_delivery/features/home/widgets/search_edit_text.dart';
import 'package:res_delivery/features/home/widgets/section_label.dart';
import 'package:res_delivery/utils/session_management.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/home_screen";
  final session = SessionManagement();

  @override
  Widget build(BuildContext context) {
    print("Home screen build is called");
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ImageSliderProvider()),
        ChangeNotifierProvider(create: (_) => MealTypeProvider()),
        ChangeNotifierProvider(create: (_) => PopularItemsProvider()),
      ],
      child: Scaffold(
        appBar: HomeAppBar(context),
        backgroundColor: Colors.white70,
        body: Container(
          color: Colors.white70,
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SearchEditText(
                  onChanged: (value) {
                    //the changed value
                  },
                ),
                SizedBox(height: 10),
                SectionLabel("Specials"),
                ImageSlider(),
                SectionLabel("Meal Type"),
                FoodTypes(),
                PopularItems(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar HomeAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.menu),
        color: Theme.of(context).primaryColor,
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      title: Text(
        "Restaurant Meals",
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white70,
      elevation: 0,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.shopping_cart),
          color: Theme.of(context).primaryColor,
          onPressed: () {
            if (session.isLoggedIn()) {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            } else {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.fixed,
                  content: Text("You must be logged in!"),
                  action: SnackBarAction(
                    label: "login".toUpperCase(),
                    textColor: Theme.of(context).accentColor,
                    onPressed: () =>
                        Navigator.of(context).pushNamed(LoginScreen.routeName),
                  ),
                ),
              );
            }
          },
        )
      ],
    );
  }
}
