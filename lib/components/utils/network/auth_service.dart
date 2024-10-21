import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AuthService {
  static const String _tokenKey = 'auth_token';
  static const String _organisation = 'organisation';
  static const String _owner = 'isOwner';
  static const String _refreshKey = 'refresh_token';
  static const String _emailId = 'email_id';
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> saveToken(String token, String refresh, bool owner,
      int organisation, String emailId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_organisation, organisation);
    await prefs.setBool(_owner, owner);
    await prefs.setString(_emailId, emailId);
    if (kIsWeb) {
      await prefs.setString(_tokenKey, token);
      await prefs.setString(_refreshKey, refresh);
    } else {
      await _secureStorage.write(key: _tokenKey, value: token);
      await _secureStorage.write(key: _refreshKey, value: refresh);
    }
  }

  Future<String?> getToken() async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_tokenKey);
    } else {
      return await _secureStorage.read(key: _tokenKey);
    }
  }

  Future<String?> getRefresh() async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_refreshKey);
    } else {
      return await _secureStorage.read(key: _refreshKey);
    }
  }

  Future<int?> getOrganisation() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_organisation);
  }

  Future<bool?> getOwner() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_owner);
  }

  Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_emailId);
  }

  Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_organisation);
    await prefs.remove(_owner);
    await prefs.remove(_emailId);
    if (kIsWeb) {
      await prefs.remove(_tokenKey);
      await prefs.remove(_refreshKey);
    } else {
      await _secureStorage.deleteAll();
    }
  }
}
