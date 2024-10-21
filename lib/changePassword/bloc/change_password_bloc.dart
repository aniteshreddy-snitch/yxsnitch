import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yxsnitch/changePassword/repository/change_password_repository.dart';
import 'package:yxsnitch/components/utils/enums.dart';
part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final ChangePasswordRepository _changePasswordRepository =
      ChangePasswordRepository();

  ChangePasswordBloc() : super(const ChangePasswordState()) {
    on<EmailChangedEvent>(_onEmailChanged);
    on<OldPasswordChangedEvent>(_onOldPasswordChanged);
    on<NewPasswordChangedEvent>(_onNewPasswordChanged);
    on<ChangePasswordSubmittedEvent>(_onChangePasswordSubmitted);
  }

  FutureOr<void> _onEmailChanged(
      EmailChangedEvent event, Emitter<ChangePasswordState> emit) {
    emit(state.copyWith(email: event.email, apiStatus: APIStatus.initial));
  }

  FutureOr<void> _onOldPasswordChanged(
      OldPasswordChangedEvent event, Emitter<ChangePasswordState> emit) {
    emit(state.copyWith(
        message: '',
        oldPassword: event.oldPassword,
        apiStatus: APIStatus.initial));
  }

  FutureOr<void> _onNewPasswordChanged(
      NewPasswordChangedEvent event, Emitter<ChangePasswordState> emit) {
    emit(state.copyWith(
        message: '',
        newPassword: event.newPassword,
        apiStatus: APIStatus.initial));
  }

  FutureOr<void> _onChangePasswordSubmitted(ChangePasswordSubmittedEvent event,
      Emitter<ChangePasswordState> emit) async {
    emit(state.copyWith(message: "", apiStatus: APIStatus.loading));
    try {
      final data = {
        "email": state.email,
        'old_password': state.oldPassword,
        'new_password': state.newPassword
      };
      // Map data = {"email": 'anitesh.reddy@yxsnitch.com', 'password': 'pass'};
      var response = await _changePasswordRepository.passwordAPI(data);
      response = jsonDecode(response);
      // print("were here");
      emit(state.copyWith(message: 'success', apiStatus: APIStatus.success));
    } catch (e) {
      String message = e.toString();
      if (message == "Exception: Invalid old password.") {
        emit(state.copyWith(
          apiStatus: APIStatus.error,
          message: "Invalid old password.",
        ));
      } else {
        emit(state.copyWith(
          apiStatus: APIStatus.error,
          message: e.toString(),
        ));
      }
    }
  }
}
