import 'package:yxsnitch/Organisation/mappers/organisation_detail_mapper.dart';
import 'package:yxsnitch/components/constants.dart';
import 'package:yxsnitch/components/utils/network/auth_service.dart';
import 'package:yxsnitch/components/utils/network/network_services.dart';

class OrganisationRepository {
  final api = NetworkApiService();

  final NetworkApiService _api = NetworkApiService();

  Future<dynamic> getOrganisationAPI() async {
    try {
      final token = await AuthService().getToken();

      var response = await _api.getApi(
          "${kbaseURL}user-management/organisations/",
          token: token.toString());

      final organisationDetail = organisationFromJson(
          response.toString().substring(1, response.toString().length - 1));

      return organisationDetail;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> postOrganisationAPI(
      OrganisationDetail organisationDetail) async {
    try {
      final token = await AuthService().getToken();
      var data = organisationToJson(organisationDetail);
      var response = await _api.patchApi(
          "${kbaseURL}user-management/organisations/${organisationDetail.id}/",
          data,
          token: token.toString());

      organisationDetail = organisationFromJson(response.toString());

      return organisationDetail;
    } catch (e) {
      rethrow;
    }
  }
}
