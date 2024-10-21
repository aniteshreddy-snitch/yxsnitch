import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:yxsnitch/components/utils/enums.dart';
import 'package:yxsnitch/components/utils/network/auth_service.dart';
import 'package:yxsnitch/dashboard/mapper/activity_list_mapper.dart';
import 'package:yxsnitch/dashboard/mapper/device_list_mapper.dart';
import 'package:yxsnitch/dashboard/repository/activity_list_repository.dart';
import 'package:yxsnitch/dashboard/repository/device_list_repository.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(const DashboardState()) {
    on<DashboardDeviceFetchEvent>(dashboardDeviceFetchEvent);
    on<DashboardActivityFetchEvent>(dashboardActivityFetchEvent);
  }

  final _deviceFetchRepository = DeviceFetchRepository();
  final _activityFetchRepository = ActivityFetchRepository();
  final AuthService _authService = AuthService();

  FutureOr<void> dashboardDeviceFetchEvent(
      DashboardDeviceFetchEvent event, Emitter<DashboardState> emit) async {
    emit(state.copyWith(deviceApiStatus: APIStatus.loading));
    try {
      String token = await _authService.getToken() ?? "";
      final deviceList = await _deviceFetchRepository.getAPI(token);
      // await Future.delayed(Duration(seconds: 3));
      // final deviceList = deviceListFromJson(response.toString());
      emit(state.copyWith(
          deviceApiStatus: APIStatus.success, deviceList: deviceList));
    } catch (e) {
      emit(state.copyWith(message: e.toString()));
    }
  }

  FutureOr<void> dashboardActivityFetchEvent(
      DashboardActivityFetchEvent event, Emitter<DashboardState> emit) async {
    emit(state.copyWith(activityApiStatus: APIStatus.loading));
    try {
      String token = await _authService.getToken() ?? "";
      final activityList = await _activityFetchRepository.getAPI(token);
      // final deviceList = deviceListFromJson(response.toString());
      // await Future.delayed(Duration(seconds: 3));

      emit(state.copyWith(
          activityApiStatus: APIStatus.success, activityList: activityList));
    } catch (e) {
      emit(state.copyWith(message: e.toString()));
    }
  }
}
