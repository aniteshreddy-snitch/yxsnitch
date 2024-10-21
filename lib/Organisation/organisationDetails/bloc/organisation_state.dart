part of 'organisation_bloc.dart';

abstract class OrganisationState extends Equatable {
  final OrganisationDetail? organisationDetail;
  final String message;
  final APIStatus apiStatus;

  const OrganisationState({
    this.organisationDetail,
    required this.message,
    required this.apiStatus,
  });

  @override
  List<Object?> get props => [organisationDetail, message, apiStatus];

  OrganisationState copyWith({
    OrganisationDetail? organisationDetail,
    String? message,
    APIStatus? apiStatus,
  });
}

class OrganisationGetState extends OrganisationState {
  const OrganisationGetState({
    super.organisationDetail,
    required super.message,
    required super.apiStatus,
  });

  @override
  OrganisationGetState copyWith(
      {OrganisationDetail? organisationDetail,
      String? message,
      APIStatus? apiStatus}) {
    return OrganisationGetState(
        organisationDetail: organisationDetail ?? this.organisationDetail,
        message: message ?? this.message,
        apiStatus: apiStatus ?? this.apiStatus);
  }

  @override
  List<Object?> get props => [organisationDetail, message, apiStatus];
}

class OrganisationPostState extends OrganisationState {
  const OrganisationPostState(
      {super.organisationDetail,
      required super.message,
      required super.apiStatus});

  @override
  OrganisationGetState copyWith(
      {OrganisationDetail? organisationDetail,
      String? message,
      APIStatus? apiStatus}) {
    return OrganisationGetState(
        organisationDetail: organisationDetail ?? this.organisationDetail,
        message: message ?? this.message,
        apiStatus: apiStatus ?? this.apiStatus);
  }

  @override
  List<Object?> get props => [organisationDetail, message, apiStatus];
}

