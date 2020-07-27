import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_delivery/features/auth/blocs/login/login_bloc.dart';
import 'package:res_delivery/features/auth/repositories/auth_repository.dart';
import 'package:res_delivery/features/auth/screens/register_screen.dart';
import 'package:res_delivery/features/auth/services/auth_service.dart';
import 'package:res_delivery/features/auth/validators.dart';
import 'package:res_delivery/utils/bottom_bar_screen.dart';
import 'package:res_delivery/utils/constants.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatelessWidget {
  static const routeName = "/login_route_name";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginBloc(AuthRepository()),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/login_background.png'),
              fit: BoxFit.fill),
        ),
        child: Scaffold(
          backgroundColor: Colors.black.withOpacity(.62),
          body: LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  String email = "";
  String password = "";

  void _onFormSubmitted(BuildContext context) {
    if (_form.currentState.validate()) {
      BlocProvider.of<LoginBloc>(context).add(
        LoginWithCredentialsPressed(
          email: email.trim(),
          password: password.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (BuildContext ctx, LoginState state) {
        if (state is LoginFailed) {
          buildSnackBar(
            context,
            [Text(state.errorMessage), Icon(Icons.error)],
            Theme.of(context).errorColor,
            Duration(seconds: 3),
          );
        }
        if (state is LoginInProgress) {
          buildSnackBar(
              context,
              [
                Text(
                  'Logging In...',
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                  height: 28,
                  width: 28,
                )
              ],
              Theme.of(context).snackBarTheme.backgroundColor,
              Duration(hours: 1));
        }
        if (state is LoginSuccess) {
          //to let the user get back to wherever he was
          Navigator.of(context).pop();
        }
      },
      builder: (BuildContext context, LoginState state) {
        return Stack(
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
                          validator: (value) => !Validators.isValidEmail(value)
                              ? "Enter valid email"
                              : null,
                          style: TextStyle(color: Colors.white),
                          decoration: formDecoration("Email"),
                          onChanged: (value) => email = value,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) =>
                              !Validators.isValidPassword(value)
                                  ? "Password must be more than 6 chars"
                                  : null,
                          style: TextStyle(color: Colors.white),
                          decoration: formDecoration("Password"),
                          obscureText: true,
                          onChanged: (value) => password = value,
                          onSaved: (value) => _onFormSubmitted(context),
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
                        Container(
                          height: 55,
                          width: double.infinity,
                          child: RaisedButton(
                            color: Theme.of(context).accentColor,
                            onPressed: () => _onFormSubmitted(context),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Sign In".toUpperCase(),
                              style: TextStyle(color: Colors.white),
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
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void buildSnackBar(BuildContext context, List<Widget> widgets, Color color,
      Duration duration) {
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: widgets,
          ),
          backgroundColor: color,
          duration: duration,
        ),
      );
  }
}
