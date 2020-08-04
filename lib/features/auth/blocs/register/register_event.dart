part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterWithCredentials extends RegisterEvent {
  final String name;
  final String email;
  final String password;

  RegisterWithCredentials({
    @required this.name,
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [name, email, password];
}
