import 'package:flutter/material.dart';
import 'package:res_delivery/features/auth/screens/login_screen.dart';
import 'package:res_delivery/utils/session_management.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String userName;
  String userEmail;
  var isLoggedIn;

  @override
  void initState() {
    super.initState();
    userEmail = SessionManagement.getValue(SessionManagement.EMAIL_KEY) ?? "";
    userName = SessionManagement.getValue(SessionManagement.NAME_KEY) ?? "";
    isLoggedIn = SessionManagement.isLoggedIn() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 190,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/drawer_header.jpg"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                bottom: 40,
                left: 20,
                child: Text(
                  userName,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              Positioned(
                bottom: 20,
                right: 10,
                left: 20,
                child: Text(
                  userEmail,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              )
            ],
          ),
          ListTile(
            leading: Icon(Icons.notifications_none),
            title: Text("Notifications"),
          ),
          if (!isLoggedIn)
            ListTile(
              onTap: () {
                Navigator.of(context, rootNavigator: true).pop();
                Navigator.of(context, rootNavigator: true)
                    .pushNamed(LoginScreen.routeName);
              },
              leading: Icon(Icons.person),
              title: Text("Login in"),
            ),
          if (isLoggedIn)
            ListTile(
              leading: Icon(Icons.payment),
              title: Text("Payment Methods"),
            ),
          if (isLoggedIn)
            ListTile(
              leading: Icon(Icons.shop),
              title: Text("Orders"),
            ),
          Divider(),
          if (isLoggedIn)
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Edit Profile"),
            ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
          ),
          Spacer(),
          Divider(),
          if (isLoggedIn)
            ListTile(
              onTap: () async {
                await SessionManagement.signOut();
                Navigator.of(context, rootNavigator: true).pop();
              },
              title: Text(
                "Log Out",
                style: TextStyle(color: Theme.of(context).errorColor),
              ),
            )
        ],
      ),
    );
  }
}
