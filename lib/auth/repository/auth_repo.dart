import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'api/api.dart';

class AuthRepo {
  final API _api = API();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<bool> hasToken() async {
    var value = await _storage.read(key: 'token');

    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> persistToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: 'token');
    _storage.deleteAll();
  }

  Future<String> login(String username, String password) async {
    _api.sendRequest.options.headers['Content-Type'] =
        'application/x-www-form-urlencoded';
    Response response = await _api.sendRequest.post(
      '/realms/bahl/protocol/openid-connect/token',
      data: {
        'client_id': 'hrms',
        'client_secret': 'NItlahoXL1C5CHbh0pXOZUXmOMdizWhF',
        'grant_type': 'password',
        'username': username,
        'password': password,
      },
    );
    return response.data['access_token'];
  }
}
