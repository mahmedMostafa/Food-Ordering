import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:res_delivery/features/auth/repositories/auth_repository.dart';
import 'package:res_delivery/features/auth/validators.dart';
import 'package:rxdart/rxdart.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;

  LoginBloc(this._authRepository) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    } else if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsToState(
        event.email,
        event.password,
      );
    }
  }

  Stream<LoginState> _mapLoginWithCredentialsToState(
      String email, String password) async* {
    yield LoginInProgress();
    try {
      await _authRepository.loginUser(email, password);
      yield LoginSuccess();
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      yield LoginFailed(errorMessage);
    } catch (error) {
      print("Error is ${error.toString()}");
      String errorMessage = 'Login Failed.';
      if (error.toString().contains("ERROR_NETWORK_REQUEST_FAILED")) {
        errorMessage = "No Network Available";
      }else if (error.toString().contains("ERROR_WRONG_PASSWORD")) {
        errorMessage = "Wrong Email or Password";
      }
      yield LoginFailed(errorMessage);
    }
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    try {
      await _authRepository.gmailLogin();
      yield LoginSuccess();
    } catch (_) {
      yield LoginFailed("Error");
    }
  }

  Stream<LoginState> _mapLoginWithFacebookPressedToState() async* {
    try {
      await _authRepository.facebookLogin();
      yield LoginSuccess();
    } catch (_) {
      yield LoginFailed("Error");
    }
  }
}
