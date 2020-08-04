import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_delivery/features/auth/screens/login_screen.dart';
import 'package:res_delivery/features/cart/presentation/cart_screen.dart';
import 'package:res_delivery/features/home/bloc/home_bloc.dart';
import 'package:res_delivery/features/home/domain/data/image_slider_data_source.dart';
import 'package:res_delivery/features/home/domain/data/meal_type_data_source.dart';
import 'package:res_delivery/features/home/domain/data/popular_items_data_source.dart';
import 'package:res_delivery/features/home/domain/home_repository.dart';
import 'package:res_delivery/features/items/presentation/items_screen.dart';
import 'package:res_delivery/utils/session_management.dart';
import 'widgets/food_types.dart';
import 'widgets/image_slider.dart';
import 'widgets/popular_items.dart';
import 'widgets/search_edit_text.dart';
import 'widgets/section_label.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffold;

  static const routeName = "/home_screen";

  const HomeScreen({Key key, this.scaffold}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Home screen build is called");
    return BlocProvider(
      create: (BuildContext context) => HomeBloc(
        homeRepository: HomeRepository(
          imageSliderDataSource: ImageSliderDataSource(),
          mealTypeDataSource: MealTypeDataSource(),
          popularItemsDataSource: PopularItemsDataSource(),
        ),
      )
        ..add(LoadImageSlider())
        ..add(LoadMealTypes())
        ..add(LoadPopulatItems()),
      child: Scaffold(
          body: HomeBody(
        state: scaffold.currentState,
      )),
    );
  }
}

class HomeBody extends StatelessWidget {
  final ScaffoldState state;

  const HomeBody({Key key, this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildHomeAppBar(context, state),
      backgroundColor: Colors.white70,
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (BuildContext context, HomeState state) {
          if (state is HomeInitial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return GestureDetector(
              child: Container(
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
                        onQuerySubmitted: (value) {
                          //the submitted value
                        },
                      ),
                      SizedBox(height: 10),
                      SectionLabel("Specials"),
                      ImageSlider(),
                      SectionLabel("Meal Type"),
                      FoodTypes(),
                      buildPopularItemsSection(context),
                      PopularItems(),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

Row buildPopularItemsSection(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      SectionLabel("Popular items"),
      Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: FlatButton(
          textColor: Theme.of(context).accentColor,
          child: Text("See All"),
          onPressed: () => Navigator.of(context, rootNavigator: true)
              .pushNamed(ItemsScreen.routeName, arguments: "chicken"),
        ),
      )
    ],
  );
}

AppBar buildHomeAppBar(BuildContext context, ScaffoldState scaffold) {
  return AppBar(
    leading: IconButton(
      icon: Icon(Icons.menu),
      color: Theme.of(context).primaryColor,
      onPressed: () {
        scaffold.openDrawer();
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
          print("is user loggedIn ? ${SessionManagement.isLoggedIn()}");
          print("is user loggedIn ? ${SessionManagement.isLoggedIn()}");
          if (SessionManagement.isLoggedIn()) {
            Navigator.of(context, rootNavigator: true)
                .pushNamed(CartScreen.routeName);
          } else {
            scaffold.showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.fixed,
                content: Text("You must be logged in!"),
                action: SnackBarAction(
                    label: "login".toUpperCase(),
                    textColor: Theme.of(context).accentColor,
                    onPressed: () => Navigator.of(context, rootNavigator: true)
                        .pushNamed(LoginScreen.routeName)),
              ),
            );
          }
        },
      )
    ],
  );
}
