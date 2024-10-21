import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:yxsnitch/components/my_exceptions.dart';
import 'package:yxsnitch/components/utils/network/base_services_api.dart';

/// Class for handling network API requests.
class NetworkApiService implements BaseApiServices {
  /// Sends a GET request to the specified [url] and returns the response.
  final kDebugMode = false;

  @override
  Future<dynamic> getApi(String url, {String token = ''}) async {
    if (kDebugMode) {
      print(url);
    }
    dynamic responseJson;
    http.Response response;

    try {
      if (token != '') {
        var requestHeaders = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': "Bearer $token"
        };
        response = await http
            .get(Uri.parse(url), headers: requestHeaders)
            .timeout(const Duration(seconds: 20));
      } else {
        response =
            await http.get(Uri.parse(url)).timeout(const Duration(seconds: 20));
      }
      responseJson = returnResponse(response);
    } on SocketException {
      throw Exception('No Internet Connection');
    }

    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }

  /// Sends a POST request to the specified [url] with the provided [data]
  /// and returns the response.

  @override
  Future<dynamic> postApi(String url, dynamic data, {String token = ''}) async {
    if (kDebugMode) {
      print(url);
      print(data);
    }

    dynamic responseJson;
    http.Response response;
    var requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': "Bearer $token"
    };

    try {
      if (token != '') {
        response = await http
            .post(
              Uri.parse(url),
              body: data,
              headers: requestHeaders,
            )
            .timeout(const Duration(seconds: 10));
      } else {
        response = await http
            .post(
              Uri.parse(url),
              body: data,
            )
            .timeout(const Duration(seconds: 10));
      }
      responseJson = returnResponse(response);
    } on SocketException {
      throw Exception('No Internet Connection');
    }

    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }

  @override
  Future<dynamic> patchApi(String url, dynamic data,
      {String token = ''}) async {
    if (kDebugMode) {
      print(url);
      print(data);
    }

    dynamic responseJson;
    http.Response response;
    var requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': "Bearer $token"
    };

    try {
      if (token != '') {
        response = await http
            .patch(
              Uri.parse(url),
              body: data,
              headers: requestHeaders,
            )
            .timeout(const Duration(seconds: 10));
      } else {
        response = await http
            .patch(
              Uri.parse(url),
              body: data,
            )
            .timeout(const Duration(seconds: 10));
      }
      responseJson = returnResponse(response);
    } on SocketException {
      throw Exception('No Internet Connection');
    }

    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }

  @override
  Future<dynamic> deleteApi(String url, String token) async {
    if (kDebugMode) {
      print(url);
    }

    dynamic responseJson;
    http.Response response;
    var requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': "Bearer $token"
    };

    try {
      response = await http
          .delete(
            Uri.parse(url),
            headers: requestHeaders,
          )
          .timeout(const Duration(seconds: 10));
     

      responseJson = returnResponse(response);
    } on SocketException {
      throw Exception('No Internet Connection');
    }

    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }

  /// Parses the [response] and returns the corresponding JSON data.
  ///
  dynamic returnResponse(http.Response response) {
    if (kDebugMode) {
      print(response.statusCode);
      print(response.body);
    }

    switch (response.statusCode) {
      case 200:
      case 201:
        var responseJson = response.body;

        return responseJson;
      case 400:
        throw DetailException(jsonDecode(response.body)['detail'][0]);
      case 401:
        throw UnauthorizedException();
      case 403:
        throw ChangePasswordException();
      case 500:
        throw Exception('Internal Server Error');
      default:
        throw Exception(jsonDecode(response.body)['detail'][0]);
    }
  }
}
