import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_delivery/transition/router.dart';
import 'package:res_delivery/utils/session_management.dart';
import 'package:res_delivery/utils/simple_bloc_observer.dart';

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
//        appBarTheme: AppBarTheme.of(context).copyWith(color: Colors.deepPurple),
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.green,
      ),
//      home: BottomBarScreen(),
      initialRoute: BottomBarScreen.routeName,
      onGenerateRoute: Router.generateRoute,
    );
  }
}
