part of 'change_password_bloc.dart';




abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();
  @override
  List<Object> get props => [];
}

class EmailChangedEvent extends ChangePasswordEvent {
  final String email;

  const EmailChangedEvent({required this.email});

  @override
  List<Object> get props => [email];
}



class OldPasswordChangedEvent extends ChangePasswordEvent {
  final String oldPassword;

  const OldPasswordChangedEvent({required this.oldPassword});

  @override
  List<Object> get props => [oldPassword];
}

class NewPasswordChangedEvent extends ChangePasswordEvent {
  final String newPassword;

  const NewPasswordChangedEvent({required this.newPassword});

  @override
  List<Object> get props => [newPassword];
}

class ChangePasswordSubmittedEvent extends ChangePasswordEvent{
  
}