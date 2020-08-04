import 'package:flutter/material.dart';
import 'package:res_delivery/features/categories/categories_screen.dart';
import 'package:res_delivery/features/favorites/favorites_screen.dart';
import 'package:res_delivery/features/home/presentation/home_screen.dart';
import 'package:res_delivery/features/home/presentation/widgets/drawer.dart';

import '../transition/router.dart';

class BottomBarScreen extends StatefulWidget {
  static const routeName = '/bottom_bar_screen';

  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
    return Scaffold(
      resizeToAvoidBottomInset: false, //for keyboard
      key: _scaffoldKey,
      drawer: MyDrawer(),
      body: WillPopScope(
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
          //this is b/c the status bar color was different idk why!
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: AppBar(
              // Here we create one to set status bar color
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ),
          body: SafeArea(
            child: Navigator(
              key: _navigatorKey,
              initialRoute: HomeScreen.routeName,
              //since our screen are in the general route we pass it here as well
              onGenerateRoute: (settings) => Router.generateBottomBarRoute(
                  settings,
                  scaffold: _scaffoldKey),
            ),
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
        ),
      ),
    );
  }
}
