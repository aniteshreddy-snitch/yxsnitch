import 'package:yxsnitch/components/constants.dart';
import 'package:yxsnitch/components/utils/network/network_services.dart';

class LoginRepository {
  final api = NetworkApiService();

  final NetworkApiService _api = NetworkApiService();

  Future<dynamic> loginAPI(Map<String, dynamic> data) async {
    try {
      var response = await _api.postApi("${kbaseURL}token/", data);
      
      
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
