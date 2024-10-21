part of 'change_password_bloc.dart';

class ChangePasswordState extends Equatable {
  final String email;
  final String oldPassword;
  final String newPassword;
  final APIStatus apiStatus;
  final String message;

  const ChangePasswordState(
      {this.email = '',
      this.oldPassword = '',
      this.newPassword = '',
      this.message = '',
      this.apiStatus = APIStatus.initial});

  ChangePasswordState copyWith(
      {String? email,
      String? oldPassword,
      String? newPassword,
      String? message,
      APIStatus? apiStatus}) {
    return ChangePasswordState(
        email: email ?? this.email,
        oldPassword: oldPassword ?? this.oldPassword,
        newPassword: newPassword ?? this.newPassword,
        message: message ?? this.message,
        apiStatus: apiStatus ?? this.apiStatus);
  }

  @override
  List<Object?> get props =>
      [email, oldPassword, newPassword, message, apiStatus];
}
