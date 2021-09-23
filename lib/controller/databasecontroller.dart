import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_app_ijm_pelanggan/models/databasemodel.dart';

class DatabaseController {
  var server = 'https://nodeapi.projectkitaid.com/user';

  Future<Databasetransaksi> getDataTransasksi(String nama) async {
    final resp = await http.post(
      Uri.parse('$server/history-transaction'),
      headers: {
        "content-type": "application/x-www-form-urlencoded",
      },
      body: {"nama": nama},
    );

    return Databasetransaksi.fromJson(jsonDecode((resp.body)));
  }
}

final databasecontroller = DatabaseController();
