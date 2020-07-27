import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:res_delivery/features/auth/repositories/auth_repository.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;

  RegisterBloc({@required this.authRepository}) : super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is RegisterWithCredentials) {
      yield* _mapRegisterWithCredentialsToState(
        event.name,
        event.email,
        event.password,
      );
    }
  }

  Stream<RegisterState> _mapRegisterWithCredentialsToState(
    String name,
    String email,
    String password,
  ) async* {
    yield RegisterInProgress();
    try {
      await authRepository.registerUser(email, password, name);
      yield RegisterSuccess();
    } catch (error) {
      print("Error is ${error.toString()}");
      var errorMessage = 'Registration failed';
      if (error.toString().contains('ERROR_EMAIL_ALREADY_IN_USE')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      }
      if (error.toString().contains("ERROR_NETWORK_REQUEST_FAILED")) {
        errorMessage = "No Network Available";
      } else if (error.toString().contains("ERROR_WRONG_PASSWORD")) {
        errorMessage = "Wrong Email or Password";
      }
      yield RegisterFailed(errorMessage);
    }
  }
}
