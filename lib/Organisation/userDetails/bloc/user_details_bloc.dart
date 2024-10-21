import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:yxsnitch/Organisation/mappers/user_list_mapper.dart';
import 'package:yxsnitch/Organisation/repository/user_detail_repository.dart';
import 'package:yxsnitch/components/my_exceptions.dart';
import 'package:yxsnitch/components/utils/enums.dart';
import 'package:equatable/equatable.dart';

part 'user_details_event.dart';
part 'user_details_state.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  UserDetailsBloc() : super(const UserDetailsState()) {
    on<GetUserDetailsEvent>(_onGetUserDetailsEvent);
    on<UserDetailsUpdateEvent>(_onUserDetailsUpdateEvent);
    on<UserDetailsDeleteEvent>(_onUserDetailsDeleteEvent);
    on<UserDetailCreateEvent>(_onUserDetailsCreateEvent);
  }
  final _userDetailRepository = UserDetailRepository();

  FutureOr<void> _onGetUserDetailsEvent(
      GetUserDetailsEvent event, Emitter<UserDetailsState> emit) async {
    emit(const UserDetailsState(
        getApiStatus: APIStatus.loading, message: "loading"));

    try {
      List<UserList> userListDetail =
          await _userDetailRepository.getUserDetailAPI();

      UserList myDetails = await _userDetailRepository.getMyDetailAPI();

      // final deviceList = deviceListFromJson(response.toString());
      emit(state.copyWith(
          message: 'Details updated',
          getApiStatus: APIStatus.success,
          myDetails: myDetails,
          userList: userListDetail));
    } on UnauthorizedException {
      emit(state.copyWith(
        getApiStatus: APIStatus.unauthorized,
        message: "Login expired please login to continue",
      ));
    } catch (e) {
      emit(state.copyWith(
        getApiStatus: APIStatus.error,
        message: e.toString(),
      ));
    }
  }

  FutureOr<void> _onUserDetailsCreateEvent(
      UserDetailCreateEvent event, Emitter<UserDetailsState> emit) async {
    emit(const UserDetailsState(postApiStatus: APIStatus.loading));

    try {
      await _userDetailRepository.createUserDetailAPI(event.userList);
      // await Future.delayed(Duration(seconds: 3));
      // final deviceList = deviceListFromJson(response.toString());
      emit(state.copyWith(
        postApiStatus: APIStatus.success,
      ));
    } on UnauthorizedException {
      emit(state.copyWith(
        postApiStatus: APIStatus.unauthorized,
        message: "Login expired please login to continue",
      ));
    } catch (e) {
      emit(state.copyWith(
        postApiStatus: APIStatus.error,
        message: e.toString(),
      ));
    }
  }

  FutureOr<void> _onUserDetailsUpdateEvent(
      UserDetailsUpdateEvent event, Emitter<UserDetailsState> emit) async {
    emit(const UserDetailsState(postApiStatus: APIStatus.loading));

    try {
      await _userDetailRepository.updateUserDetailAPI(event.userList);
      // await Future.delayed(Duration(seconds: 3));
      // final deviceList = deviceListFromJson(response.toString());
      emit(state.copyWith(
        postApiStatus: APIStatus.success,
      ));
    } on UnauthorizedException {
      emit(state.copyWith(
        postApiStatus: APIStatus.unauthorized,
        message: "Login expired please login to continue",
      ));
    } catch (e) {
      emit(state.copyWith(
        postApiStatus: APIStatus.error,
        message: e.toString(),
      ));
    }
  }

  FutureOr<void> _onUserDetailsDeleteEvent(
      UserDetailsDeleteEvent event, Emitter<UserDetailsState> emit) async {
    emit(const UserDetailsState(postApiStatus: APIStatus.loading));

    try {
      await _userDetailRepository.deleteUserDetailAPI(event.userId);
      // await Future.delayed(Duration(seconds: 3));
      // final deviceList = deviceListFromJson(response.toString());
      emit(state.copyWith(
        deleteApiStatus: APIStatus.success,
      ));
    } on ChangePasswordException {
      emit(state.copyWith(
        postApiStatus: APIStatus.error,
        message: "Admin account cannot be deleted",
      ));
    } on UnauthorizedException {
      emit(state.copyWith(
        postApiStatus: APIStatus.unauthorized,
        message: "Login expired please login to continue",
      ));
    } catch (e) {
      emit(state.copyWith(
        postApiStatus: APIStatus.error,
        message: e.toString(),
      ));
    }
  }
}
