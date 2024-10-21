part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => [];
}

class EmailChangedEvent extends LoginEvent {
  final String email;

  const EmailChangedEvent({required this.email});

  @override
  List<Object> get props => [email];
}

class EmailUnfocused extends LoginEvent {}

class PasswordChangedEvent extends LoginEvent {
  final String password;

  const PasswordChangedEvent({required this.password});

  @override
  List<Object> get props => [password];
}

class PasswordUnfocused extends LoginEvent {}

class LoginFormSubmitted extends LoginEvent {}
