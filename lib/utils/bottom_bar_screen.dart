import 'package:flutter/material.dart';
import 'package:res_delivery/features/favorites/favorites_screen.dart';
import 'package:res_delivery/features/home/presentation/home_screen.dart';
import 'package:res_delivery/features/home/presentation/widgets/drawer.dart';
import 'package:res_delivery/features/categories/categories_screen.dart';

class BottomBarScreen extends StatefulWidget {
  static const routeName = '/bottom_bar_screen';

  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  final List<String> routes = [
    HomeScreen.routeName,
    FavoritesScreen.routeName,
    CategoriesScreen.routeName
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    _navigatorKey.currentState.pushNamed(routes[index]).then((value) => {
          setState(() {
            _navigatorKey.currentState.popUntil((route) => route.isFirst);
            _selectedPageIndex = 0;
          })
        });
    setState(() => _selectedPageIndex = index);
  }

  /*
      this bottom bar handle the back stack to the home page always (android back and up button)
   */
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print("onWillPop is Called");
        if (_navigatorKey.currentState.canPop()) {
          //this is to selected the last bottom bar item
          setState(() => _selectedPageIndex = 0);
          _navigatorKey.currentState.popUntil((route) => route.isFirst);
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: Navigator(
          key: _navigatorKey,
          onGenerateRoute: generateRoute,
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: _selectPage,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedPageIndex,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: Theme.of(context).primaryColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              title: Text('Favorites'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              title: Text('Categories'),
            ),
          ],
        ),
        drawer: MyDrawer(),
      ),
    );
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case FavoritesScreen.routeName:
        return MaterialPageRoute(builder: (context) => FavoritesScreen());
      case CategoriesScreen.routeName:
        return MaterialPageRoute(builder: (context) => CategoriesScreen());
      default:
        return MaterialPageRoute(builder: (context) => HomeScreen());
    }
  }
}
