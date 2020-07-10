import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:res_delivery/features/auth/screens/register_screen.dart';
import 'package:res_delivery/features/auth/services/auth_service.dart';
import 'package:res_delivery/utils/bottom_bar_screen.dart';
import 'package:res_delivery/utils/constants.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  static const routeName = "login_route";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = AuthService();
  final _form = GlobalKey<FormState>();
  String email = "";
  String password = "";
  var _isLoading = false;

  void submitForm() async {
    if (_form.currentState.validate()) {
      print("Email is $email and password is $password");
      setState(() => _isLoading = true);
      try {
        await _auth.loginUser(email, password);
        setState(() => _isLoading = false);
        Navigator.of(context).pushNamed(BottomBarScreen.routeName);
      } catch (error) {
        setState(() => _isLoading = false);
        print(error.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/login_background.png'), fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(.62),
        body: Stack(
          children: <Widget>[
            Form(
              key: _form,
              child: Positioned(
                top: size.height * .3,
                left: 0,
                right: 0,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: const Text(
                            "Sign in to continue",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) =>
                              !value.contains("@") ? "Enter valid email" : null,
                          style: TextStyle(color: Colors.white),
                          decoration: formDecoration("Email"),
                          onChanged: (value) => email = value,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) =>
                              value.length < 6 ? "Password is too small" : null,
                          style: TextStyle(color: Colors.white),
                          decoration: formDecoration("Password"),
                          obscureText: true,
                          onChanged: (value) => password = value,
                          onSaved: (value) {
                            submitForm();
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(color: whiteTextColor),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        InkWell(
                          onTap: submitForm,
                          child: Container(
                            width: double.infinity,
                            height: 55,
                            decoration: BoxDecoration(
                                color: Theme.of(context).accentColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                "Sign in".toUpperCase(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Don't have an account?   ",
                                style: TextStyle(color: Colors.white)),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(RegisterScreen.routName);
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(color: whiteTextColor),
                              ),
                            )
                          ],
                        ),
                        if (_isLoading)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


