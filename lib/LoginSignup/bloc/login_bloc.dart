import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yxsnitch/LoginSignup/repository/login_repository.dart';
import 'package:yxsnitch/components/my_exceptions.dart';
import 'package:yxsnitch/components/utils/enums.dart';
import 'package:yxsnitch/components/utils/network/auth_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _loginRepository = LoginRepository();
  final AuthService _authService = AuthService();

  LoginBloc() : super(const LoginState()) {
    on<EmailChangedEvent>(_onEmailChanged);
    on<PasswordChangedEvent>(_onPasswordChanged);
    on<LoginFormSubmitted>(_onLoginFormSubmitted);
  }
  void _onEmailChanged(EmailChangedEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email, apiStatus: APIStatus.initial));
  }

  void _onPasswordChanged(
      PasswordChangedEvent event, Emitter<LoginState> emit) {
    emit(
        state.copyWith(password: event.password, apiStatus: APIStatus.initial));
  }

  void _onLoginFormSubmitted(
      LoginFormSubmitted event, Emitter<LoginState> emit) async {
    emit(state.copyWith(apiStatus: APIStatus.loading));
    try {
      final data = {"email": state.email, 'password': state.password};
      // Map data = {"email": 'anitesh.reddy@yxsnitch.com', 'password': 'pass'};
      var response = await _loginRepository.loginAPI(data);
      response = jsonDecode(response);
      if (response['access'] != null) {
        await _authService.saveToken(response['access'], response['refresh'],
            response['is_owner'], response['organisation'], response['email']);

        emit(state.copyWith(apiStatus: APIStatus.success));
      } else {
        emit(state.copyWith(
          apiStatus: APIStatus.error,
          message: response['detail'][0] ?? 'Login failed',
        ));
      }
      // ignore: unused_catch_clause
    } on UnauthorizedException catch (e) {
      emit(state.copyWith(
        apiStatus: APIStatus.error,
        message: "Incorrect Login details",
      ));
      // ignore: unused_catch_clause
    } on ChangePasswordException catch (e) {
      emit(state.copyWith(
        apiStatus: APIStatus.changePassword,
        message: "Incorrect Login details",
      ));
    } catch (e) {
      emit(state.copyWith(
        apiStatus: APIStatus.error,
        message: e.toString(),
      ));
    }
  }
}
