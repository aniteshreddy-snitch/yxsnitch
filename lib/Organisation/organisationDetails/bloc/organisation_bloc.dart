import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yxsnitch/Organisation/mappers/organisation_detail_mapper.dart';
import 'package:yxsnitch/Organisation/mappers/user_list_mapper.dart';
import 'package:yxsnitch/Organisation/repository/organisation_detail_repository.dart';
import 'package:yxsnitch/components/my_exceptions.dart';
import 'package:yxsnitch/components/utils/enums.dart';
part 'organisation_event.dart';
part 'organisation_state.dart';

class OrganisationBloc extends Bloc<OrganisationEvent, OrganisationState> {
  OrganisationBloc()
      : super(const OrganisationGetState(
          message: '',
          apiStatus: APIStatus.initial,
        )) {
    // on<NameChangedEvent>(_onNameChanged);
    // on<StreetAddressChangedEvent>(_onStreetAddressChanged);
    // on<PincodeChangedEvent>(__onPincodeChanged);
    // on<CityChangedEvent>(_onCityChanged);
    // on<StateChangedEvent>(_onStateChanged);
    on<OrganisationFetchEvent>(_onOrganisationFetchEvent);
    on<OrganisationUpdateDetailsEvent>(_onOrganisationUpdateEvent);
  }

  final _organisationRepository = OrganisationRepository();

  FutureOr<void> _onOrganisationFetchEvent(
      OrganisationFetchEvent event, Emitter<OrganisationState> emit) async {
    emit(const OrganisationGetState(
        apiStatus: APIStatus.loading, message: "loading"));

    try {
      OrganisationDetail organisationDetail =
          await _organisationRepository.getOrganisationAPI();
      // final deviceList = deviceListFromJson(response.toString());
      emit((state as OrganisationGetState).copyWith(
          message: 'Details updated',
          apiStatus: APIStatus.success,
          organisationDetail: organisationDetail));
    } on UnauthorizedException {
      print("unauthorized");
      emit((state as OrganisationGetState).copyWith(
        apiStatus: APIStatus.unauthorized,
        message: "Login expired please login to continue",
      ));
    } catch (e) {
      emit((state as OrganisationGetState).copyWith(
        apiStatus: APIStatus.error,
        message: e.toString(),
      ));
    }
  }

  void _onOrganisationUpdateEvent(OrganisationUpdateDetailsEvent event,
      Emitter<OrganisationState> emit) async {
    emit(const OrganisationPostState(
      message: '',
      apiStatus: APIStatus.loading,
    ));

    // emit(state.copyWith(apiStatus: APIStatus.success));
    try {
      final organisationDetail = await _organisationRepository
          .postOrganisationAPI(event.organisationDetail);
      // final deviceList = deviceListFromJson(response.toString());

      emit(state.copyWith(
          apiStatus: APIStatus.success,
          organisationDetail: organisationDetail));
    } on UnauthorizedException {
      emit(state.copyWith(
        apiStatus: APIStatus.unauthorized,
        message: "Login expired please login to continue",
      ));
    } catch (e) {
      emit(state.copyWith(
        apiStatus: APIStatus.error,
        message: e.toString(),
      ));
    }
  }
}
