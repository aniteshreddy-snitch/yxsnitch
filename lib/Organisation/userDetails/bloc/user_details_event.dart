part of 'user_details_bloc.dart';

@immutable
sealed class UserDetailsEvent {}

class GetUserDetailsEvent extends UserDetailsEvent{}

class UserDetailsUpdateEvent extends UserDetailsEvent{
   final UserList userList;

   UserDetailsUpdateEvent({required this.userList});

  List<Object> get props => [userList];
}

class UserDetailsDeleteEvent extends UserDetailsEvent{
   final int userId;

   UserDetailsDeleteEvent({required this.userId});

  List<Object> get props => [userId];
}

class UserDetailCreateEvent extends UserDetailsEvent{
   final UserList userList;

   UserDetailCreateEvent({required this.userList});

  List<Object> get props => [userList];
}


