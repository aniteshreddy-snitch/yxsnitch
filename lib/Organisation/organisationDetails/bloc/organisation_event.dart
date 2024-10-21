part of 'organisation_bloc.dart';

abstract class OrganisationEvent extends Equatable {
  const OrganisationEvent();
  @override
  List<Object> get props => [];
}

class NameChangedEvent extends OrganisationEvent {
  final String name;

  const NameChangedEvent({required this.name});

  @override
  List<Object> get props => [name];
}

class StreetAddressChangedEvent extends OrganisationEvent {
  final String streetAddress;
  const StreetAddressChangedEvent({required this.streetAddress});

  @override
  List<Object> get props => [streetAddress];
}

class PincodeChangedEvent extends OrganisationEvent {
  final int pincode;
  const PincodeChangedEvent({required this.pincode});

  @override
  List<Object> get props => [pincode];
}

class CityChangedEvent extends OrganisationEvent {
  final String city;
  const CityChangedEvent({required this.city});

  @override
  List<Object> get props => [city];
}

class StateChangedEvent extends OrganisationEvent {
  final String state;
  const StateChangedEvent({required this.state});

  @override
  List<Object> get props => [state];
}

class OrganisationFormSubmittedEvent extends OrganisationEvent {}

class OrganisationFetchEvent extends OrganisationEvent {}

class OrganisationUsersFetchEvent extends OrganisationEvent {
  final List<UserList> userList;

  const OrganisationUsersFetchEvent({required this.userList});

  @override
  List<Object> get props => [userList];
}

class OrganisationUpdateDetailsEvent extends OrganisationEvent {
  final OrganisationDetail organisationDetail;
  const OrganisationUpdateDetailsEvent({required this.organisationDetail});
  @override
  List<Object> get props => [organisationDetail];
}
