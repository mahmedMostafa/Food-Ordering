import 'package:flutter/material.dart';
import 'package:res_delivery/features/auth/services/auth_service.dart';
import 'package:res_delivery/utils/bottom_bar_screen.dart';
import 'package:res_delivery/utils/constants.dart';

class RegisterScreen extends StatefulWidget {
  static const routName = '/register_route';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = AuthService();
  final _form = GlobalKey<FormState>();

  String _email = "";
  String _password = "";
  String _name = "";
  var _isLoading = false;

  void submitForm() async {
    if (_form.currentState.validate()) {
      print("Email is $_email and password is $_password");
      setState(() => _isLoading = true);
      try {
        await _auth.registerUser(_email, _password, _name);
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
            image: AssetImage('assets/register_background.png'),
            fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(.32),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: const Text(
                          "Register an Account",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: formDecoration("Name"),
                        onChanged: (value) => _name = value,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                            !value.contains("@") ? "Enter valid email" : null,
                        style: TextStyle(color: Colors.white),
                        decoration: formDecoration("Email"),
                        onChanged: (value) => _email = value,
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
                        onChanged: (value) => _password = value,
                        onSaved: (value) {
                          submitForm();
                        },
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
                              "Register".toUpperCase(),
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
                          Text("Already have an account?   ",
                              style: TextStyle(color: Colors.white)),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Login",
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
            )
          ],
        ),
      ),
    );
  }
}
