import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_app_ijm_pelanggan/models/uploadimagemodels.dart';

class ImageController {
  var server = 'https://nodeapi.projectkitaid.com/user';

  Future<UploadImage> uploadImageTransaction(
      String image, String rwo, String nama, String nomor) async {
    var request = http.MultipartRequest(
        'PUT', Uri.parse('$server/upload-image-transaction'))
      ..headers['Accept'] = 'application/json'
      ..fields['rwo'] = '$rwo'
      ..fields['nama'] = '$nama'
      ..fields['nomor'] = '$nomor'
      ..files.add(await http.MultipartFile.fromPath(
        'rwo',
        image,
      ));

    final resp = await request.send();

    var data = await http.Response.fromStream(resp);

    return UploadImage.fromJson(jsonDecode(data.body));
  }

  Future<UploadImage> uploadImageTabung(
      String image, String nama, String status, String namaUser) async {
    var request = http.MultipartRequest(
        'PUT', Uri.parse('$server/upload-image-tabung-user'))
      ..headers['Accept'] = 'application/json'
      ..fields['nama_tabung'] = nama
      ..fields['status'] = status
      ..fields['nama_user'] = namaUser
      ..files.add(await http.MultipartFile.fromPath('Tabung-user', image));

    final resp = await request.send();

    var data = await http.Response.fromStream(resp);

    return UploadImage.fromJson(jsonDecode(data.body));
  }

  Future<DeleteImageModel> deleteImageTabung(
      String namaTabung, String namaUser) async {
    final body = {"nama_tabung": namaTabung, "nama": namaUser};
    final resp = await http.delete(
      Uri.parse('$server/delete-image-tabung'),
      headers: {"content-type": "application/x-www-form-urlencoded"},
      body: body,
    );

    return DeleteImageModel.fromJson(jsonDecode(resp.body));
  }
}

final uploadImageController = ImageController();
