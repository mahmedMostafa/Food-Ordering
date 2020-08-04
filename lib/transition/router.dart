import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:res_delivery/features/auth/screens/login_screen.dart';
import 'package:res_delivery/features/auth/screens/register_screen.dart';
import 'package:res_delivery/features/cart/presentation/cart_screen.dart';
import 'package:res_delivery/features/categories/categories_screen.dart';
import 'package:res_delivery/features/details/details_argument.dart';
import 'package:res_delivery/features/details/presentation/details_screen.dart';
import 'package:res_delivery/features/favorites/favorites_screen.dart';
import 'package:res_delivery/features/home/presentation/home_screen.dart';
import 'package:res_delivery/features/items/presentation/items_screen.dart';
import 'package:res_delivery/transition/routes/enter_exit_route.dart';
import 'package:res_delivery/transition/routes/fade_route.dart';
import 'package:res_delivery/transition/routes/slide_route.dart';
import 'package:res_delivery/utils/bottom_bar_screen.dart';

//this class takes control of all the route transactions with different route builders for transition animation
class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ItemsScreen.routeName:
        //VIP don't forget to pass the data as arguments and receive them as constructor parameters
        var data = settings.arguments as String;
        return SlideTopRoute(page: ItemsScreen(query: data));
      case BottomBarScreen.routeName:
        return CupertinoPageRoute(builder: (ctx) => BottomBarScreen());
      case CartScreen.routeName:
        return CupertinoPageRoute(builder: (ctx) => CartScreen());
      case DetailsScreen.routeName:
        DetailsArgument args = settings.arguments as DetailsArgument;
        return CupertinoPageRoute(
          builder: (ctx) => DetailsScreen(
            args: args,
          ),
        );
      case FavoritesScreen.routeName:
        return FadeRoute(page: FavoritesScreen());
      case CategoriesScreen.routeName:
        return FadeRoute(page: CategoriesScreen());
      case LoginScreen.routeName:
        return CupertinoPageRoute(builder: (ctx) => LoginScreen());
      case RegisterScreen.routName:
        return EnterExitRoute(
            enterPage: RegisterScreen(), exitPage: LoginScreen());
      default:
        return MaterialPageRoute(
          builder: (ctx) => Scaffold(
            body: Center(
              child: Text("No Route defined for ${settings.name}"),
            ),
          ),
        );
    }
  }

  //we only passed the scaffold key as an optional parameter for the bottom bar screen since we want to show the snackbar
  //and the drawer above the bottom bar
  static Route<dynamic> generateBottomBarRoute(
    RouteSettings settings, {
    GlobalKey<ScaffoldState> scaffold,
  }) {
    switch (settings.name) {
      case FavoritesScreen.routeName:
        return FadeRoute(page: FavoritesScreen());
      case CategoriesScreen.routeName:
        return FadeRoute(page: CategoriesScreen());
      default:
        return FadeRoute(page: HomeScreen(scaffold: scaffold));
    }
  }
}
