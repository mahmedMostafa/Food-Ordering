import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:res_delivery/features/cart/providers/cart_provider.dart';
import 'package:res_delivery/features/cart/screens/cart_screen.dart';
import 'package:res_delivery/features/details/providers/details_provider.dart';
import 'package:res_delivery/features/items/items_screen.dart';
import 'package:res_delivery/utils/connection_status.dart';
import './features/favorites/favorites_screen.dart';
import 'features/details/details_screen.dart';
import 'features/home/providers/items_provider.dart';
import 'utils/bottom_bar_screen.dart';
import './features/home/home_screen.dart';
import './features/splash/splash_screen.dart';
import './features/auth/screens/login_screen.dart';
import './features/auth/screens/register_screen.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ItemsProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => DetailsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Restaurant Menu',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.green,
        ),
        home: LoginScreen(),
        routes: {
          ItemsScreen.routeName: (ctx) => ItemsScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          DetailsScreen.routeName: (ctx) => DetailsScreen(),
          BottomBarScreen.routeName: (ctx) => BottomBarScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
          FavoritesScreen.routeName: (ctx) => FavoritesScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
          RegisterScreen.routName: (ctx) => RegisterScreen()
        },
      ),
    );
  }
}
