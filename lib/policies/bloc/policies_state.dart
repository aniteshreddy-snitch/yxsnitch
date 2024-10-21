part of 'policies_bloc.dart';

@immutable
sealed class PoliciesState {}

final class PoliciesInitial extends PoliciesState {}

final class PoliciesLoaded extends PoliciesState{}
