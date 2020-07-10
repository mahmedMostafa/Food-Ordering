import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 190,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/drawer_header.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.notifications_none),
            title: Text("Notifications"),
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text("Payment Methods"),
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text("Orders"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Edit Profile"),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
          ),
          Expanded(
            child: SizedBox(),
          ),
          Divider(),
          ListTile(
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
