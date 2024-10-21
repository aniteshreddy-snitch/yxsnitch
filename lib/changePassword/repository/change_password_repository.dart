
import 'package:yxsnitch/components/constants.dart';
import 'package:yxsnitch/components/utils/network/network_services.dart';

class ChangePasswordRepository {
  final api = NetworkApiService();

  final NetworkApiService _api = NetworkApiService();

  Future<dynamic> passwordAPI(Map<String, dynamic> data) async {
    try {
      var response = await _api.postApi("${kbaseURL}user-management/change_password/", data);
      
      
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
