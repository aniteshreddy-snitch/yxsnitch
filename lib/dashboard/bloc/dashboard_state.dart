part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  final List<DeviceList> deviceList;
  final List<ActivityList> activityList;
  final APIStatus deviceApiStatus;
  final String message;
  final APIStatus activityApiStatus;


  const DashboardState({
    this.message = '',
    this.deviceApiStatus = APIStatus.initial,
    this.activityApiStatus = APIStatus.initial,
    this.deviceList = const [],
    this.activityList = const []
  });

  DashboardState copyWith(
      {String? message, APIStatus? deviceApiStatus, APIStatus? activityApiStatus, List<DeviceList>? deviceList, List<ActivityList>? activityList}) {
    return DashboardState(
      message: message ?? this.message,
      deviceApiStatus: deviceApiStatus ?? this.deviceApiStatus,
      activityApiStatus: activityApiStatus?? this.activityApiStatus,
      deviceList: deviceList ?? this.deviceList,
      activityList: activityList ?? this.activityList
    );
  }

  @override
  List<Object?> get props => [message, deviceApiStatus, activityApiStatus, deviceList, activityList];
}
