part of 'login_bloc.dart';

@immutable
class LoginState {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailed extends LoginState {
  final String errorMessage;

  LoginFailed(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
