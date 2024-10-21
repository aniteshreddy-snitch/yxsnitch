part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}

class DashboardDeviceFetchEvent extends DashboardEvent{}

class DashboardActivityFetchEvent extends DashboardEvent{}
