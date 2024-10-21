import 'package:yxsnitch/components/constants.dart';
import 'package:yxsnitch/components/utils/network/network_services.dart';
import 'package:yxsnitch/dashboard/mapper/activity_list_mapper.dart';

class ActivityFetchRepository {
  final NetworkApiService _api = NetworkApiService();

  Future<dynamic> getAPI(String token) async {
    try {
      var response =
          await _api.getApi("${kbaseURL}device-activities/", token: token);

      final activityList = activityListFromJson(response.toString());
      // print(response.toString());
      return activityList;
    } catch (e) {
      rethrow;
    }
  }
}
