import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_delivery/utils/session_management.dart';
import 'features/cart/presentation/cart_screen.dart';
import 'features/items/presentation/items_screen.dart';
import 'package:res_delivery/utils/simple_bloc_observer.dart';
import './features/auth/screens/login_screen.dart';
import './features/auth/screens/register_screen.dart';
import './features/favorites/favorites_screen.dart';
import 'features/home/presentation/home_screen.dart';
import 'features/details/presentation/details_screen.dart';
import 'utils/bottom_bar_screen.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SessionManagement.init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant Menu',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.green,
      ),
      home: BottomBarScreen(),
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
    );
  }
}
