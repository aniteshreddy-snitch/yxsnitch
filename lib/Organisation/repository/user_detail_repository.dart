import 'package:yxsnitch/Organisation/mappers/user_list_mapper.dart';
import 'package:yxsnitch/components/constants.dart';
import 'package:yxsnitch/components/utils/network/auth_service.dart';
import 'package:yxsnitch/components/utils/network/network_services.dart';

class UserDetailRepository {
  final api = NetworkApiService();

  final NetworkApiService _api = NetworkApiService();

  Future<dynamic> getUserDetailAPI() async {
    try {
      final token = await AuthService().getToken();

      var response = await _api.getApi("${kbaseURL}user-management/users/",
          token: token.toString());

      final userList = userListFromJson(response.toString());

      return userList;
    } catch (e) {
      rethrow;
    }
  }

   Future<dynamic> getMyDetailAPI() async {
    try {
      final token = await AuthService().getToken();

      var response = await _api.getApi("${kbaseURL}user-management/users/myaccount",
          token: token.toString());

      final userDetail = userDetailFromJson(response.toString());

      return userDetail;
    } catch (e) {
      rethrow;
    }
  }

    Future<dynamic> createUserDetailAPI(UserList? userList) async {
    try {
      final token = await AuthService().getToken();

      var data = userObjecttoJson(userList!);
      print(data);
      var response = await _api.postApi(
          "${kbaseURL}user-management/users/", data,
          token: token.toString());

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> updateUserDetailAPI(UserList? userList) async {
    try {
      final token = await AuthService().getToken();

      var data = userObjecttoJson(userList!);
      print(data);
      var response = await _api.patchApi(
          "${kbaseURL}user-management/users/${userList.id}/", data,
          token: token.toString());

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteUserDetailAPI(int userId) async {
    try {
      final token = await AuthService().getToken();

      var response = await _api.deleteApi(
          "${kbaseURL}user-management/users/$userId/", token.toString());
     
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
