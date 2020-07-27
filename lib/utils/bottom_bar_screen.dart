import 'package:flutter/material.dart';
import 'package:res_delivery/features/favorites/favorites_screen.dart';
import 'file:///H:/Flutter%20Apps/ResDelivery/res_delivery/lib/features/home/presentation/home_screen.dart';
import 'package:res_delivery/features/home/presentation/widgets/drawer.dart';

class BottomBarScreen extends StatefulWidget {
  static const routeName = '/bottom_bar_screen';

  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  final List<Map<String, Object>> _pages = [
    {'page': HomeScreen(), 'title': 'Home'},
    {'page': FavoritesScreen(), 'title': 'Favorites'}
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) => setState(() => _selectedPageIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: _selectPage,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedPageIndex,
        showSelectedLabels: true,
        showUnselectedLabels: false,
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
        ],
      ),
      drawer: MyDrawer(),
    );
  }
}
