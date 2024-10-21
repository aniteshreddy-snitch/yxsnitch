part of 'user_details_bloc.dart';

class UserDetailsState extends Equatable {
  final List<UserList> userList;
  final APIStatus getApiStatus;
  final APIStatus postApiStatus;
  final UserList? updateUser;
  final APIStatus deleteApiStatus;
  final String message;
  final UserList? myDetails;

  const UserDetailsState(
      {this.userList = const [],
      this.message = '',
      this.getApiStatus = APIStatus.initial,
      this.postApiStatus = APIStatus.initial,
      this.deleteApiStatus = APIStatus.initial,
      this.updateUser, this.myDetails});

  UserDetailsState copyWith(
      {List<UserList>? userList,
      String? message,
      APIStatus? getApiStatus,
      APIStatus? postApiStatus,
      APIStatus? deleteApiStatus,
      UserList? updateUser, UserList? myDetails}) {
    return UserDetailsState(
      userList: userList ?? this.userList,
      message: message ?? this.message,
      getApiStatus: getApiStatus ?? this.getApiStatus,
      postApiStatus: postApiStatus ?? this.postApiStatus,
      deleteApiStatus: deleteApiStatus ?? this.deleteApiStatus,
      updateUser: updateUser ?? this.updateUser,
      myDetails: myDetails?? this.myDetails
    );
  }

  @override
  List<Object?> get props => [
        userList,
        message,
        getApiStatus,
        postApiStatus,
        deleteApiStatus,
        updateUser,
        myDetails
      ];
}
