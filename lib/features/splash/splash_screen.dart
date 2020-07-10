import 'dart:async';

import 'package:flutter/material.dart';
import 'package:res_delivery/features/home/home_screen.dart';
import 'package:res_delivery/utils/bottom_bar_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void didChangeDependencies() {
    Timer(
      const Duration(seconds: 10),
          () => Navigator.of(context).pushReplacementNamed(BottomBarScreen.routeName),
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
//    final width = MediaQuery.of(context).size.width;
//    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
//        margin: EdgeInsets.only(top: mediaQuery.padding.top),
            child: Image(
              image: AssetImage(
                'assets/splash.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(.4),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Restaurant Menu offers you all the meals with payment and delivery services",
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
