part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String email;
  final String password;
  final APIStatus apiStatus;
  final String message;

  const LoginState(
      {this.email = '',
      this.password = '',
      this.message = '',
      this.apiStatus = APIStatus.initial});

  LoginState copyWith(
      {String? email, String? password, String? message, APIStatus? apiStatus}) {
    return LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        message: message ?? this.message,
        apiStatus: apiStatus ?? this.apiStatus);
  }

  @override
  List<Object?> get props => [email, password, message, apiStatus];
}
