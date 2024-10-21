import 'package:yxsnitch/components/constants.dart';
import 'package:yxsnitch/components/utils/network/network_services.dart';
import 'package:yxsnitch/dashboard/mapper/device_list_mapper.dart';

class DeviceFetchRepository {
  final NetworkApiService _api = NetworkApiService();

  Future<dynamic> getAPI(String token) async {
    try {
      var response = await _api.getApi("${kbaseURL}devices/", token: token);
      final deviceList = deviceListFromJson(response.toString());
      // print(response.toString());
      return deviceList;
    } catch (e) {
      rethrow;
    }
  }
}
