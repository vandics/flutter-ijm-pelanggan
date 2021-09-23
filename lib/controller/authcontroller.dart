import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app_ijm_pelanggan/models/authmodels.dart';
import 'package:mobile_app_ijm_pelanggan/models/responsemodels.dart';

class AuthController {
  var server = 'https://nodeapi.projectkitaid.com/user';

  final secureStorage = FlutterSecureStorage();

  Future<AuthModel> login(
      {required String username, required String password}) async {
    final body = {'username': username, 'paswordd': password};
    final resp = await http.post(
      Uri.parse('$server/login'),
      headers: {
        "content-type": "application/json",
      },
      body: jsonEncode(body),
    );

    return AuthModel.fromJson(jsonDecode(resp.body));
  }

  Future<ResponseModels> createUser(
      {required String nama,
      required String alamat,
      required String username,
      required String password,
      required String instansi,
      required String telpon}) async {
    final body = {
      'username': password,
      'nama': nama, //benar
      'instansi': alamat, //benar
      'paswordd': instansi,
      'telepon': telpon, // benar
      'alamat': username // benar
    };
    final resp = await http.post(
      Uri.parse('$server/register'),
      headers: {
        "content-type": "application/x-www-form-urlencoded",
      },
      body: (body),
    );

    return ResponseModels.fromJson(jsonDecode(resp.body));
  }

  Future<AuthModel> renewToken() async {
    final String? token = await readToken();

    final resp = await http.get(
      Uri.parse('$server/login/renew'),
      headers: {
        'Accept': 'application/json',
        'xx-token': token!,
      },
    );

    return AuthModel.fromJson(jsonDecode(resp.body));
  }

  // Flutter Secure Storage

  Future<void> persistenToken(String token) async {
    await secureStorage.write(key: 'xtoken', value: token);
  }

  Future<String?> uidPersonStorage() async {
    return secureStorage.read(key: 'uid');
  }

  Future<bool> hasToken() async {
    var value = await secureStorage.read(key: 'xtoken');

    if (value != null) return true;
    return false;
  }

  Future<String?> readToken() async {
    return secureStorage.read(key: 'xtoken');
  }

  Future<void> deleteToken() async {
    secureStorage.delete(key: 'xtoken');
    secureStorage.deleteAll();
  }
}

final authController = AuthController();
