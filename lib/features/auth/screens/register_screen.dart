import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_delivery/features/auth/blocs/register/register_bloc.dart';
import 'package:res_delivery/features/auth/repositories/auth_repository.dart';
import 'package:res_delivery/features/auth/services/auth_service.dart';
import 'package:res_delivery/utils/bottom_bar_screen.dart';
import 'package:res_delivery/utils/constants.dart';

class RegisterScreen extends StatelessWidget {
  static const routName = '/register_route';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => RegisterBloc(authRepository: AuthRepository()),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/register_background.png'),
              fit: BoxFit.fill),
        ),
        child: Scaffold(
          backgroundColor: Colors.black.withOpacity(.32),
          body: RegisterForm(),
        ),
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {
  final _form = GlobalKey<FormState>();

  String _email = "";
  String _password = "";
  String _name = "";
  var _isLoading = false;

  void submitForm(BuildContext context) {
    if (_form.currentState.validate()) {
      BlocProvider.of<RegisterBloc>(context).add(
        RegisterWithCredentials(
            name: _name, email: _email, password: _password),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterInProgress) {
          buildSnackBar(
            context,
            [
              Text(
                'Signing up...',
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
          );
        } else if (state is RegisterFailed) {
          buildSnackBar(context, [Text(state.errorMessage), Icon(Icons.error)],
              Theme.of(context).errorColor);
        } else if (state is RegisterSuccess) {
          Navigator.of(context).pushNamed(BottomBarScreen.routeName);
        }
      },
      builder: (context, state) {
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
                        onSaved: (value) => submitForm(context),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      InkWell(
                        onTap: () => submitForm(context),
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
        );
      },
    );
  }

  void buildSnackBar(BuildContext context, List<Widget> widgets, Color color) {
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: widgets,
          ),
          backgroundColor: color,
        ),
      );
  }
}
