import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app_ijm_pelanggan/models/personalinformation.dart';

class PersonalController {
  var server = 'https://nodeapi.projectkitaid.com/user';

  final secureStorage = FlutterSecureStorage();

  Future<PersonalInformationResponse> getPersonalInformation(
      {required String username}) async {
    //final token = await authController.readToken() as String;

    try {
      final resp = await http.post(
        Uri.parse('$server/profile'),
        headers: {
          "content-type": "application/x-www-form-urlencoded",
        },
        body: {"username": username},
      );

      return PersonalInformationResponse.fromJson(jsonDecode(((resp.body))));
    } catch (e) {
      return PersonalInformationResponse(
        resp: false,
        msj: e.toString(),
        information: Information(
          nama: 'none',
          alamat: 'none',
          instansi: 'none',
          username: username,
          telpon: 'none',
          nomorpesan: 0,
        ),
      );
    }
  }
}

final personalController = PersonalController();
