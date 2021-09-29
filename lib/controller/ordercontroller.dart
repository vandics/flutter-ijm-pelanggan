import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_app_ijm_pelanggan/models/responsemodels.dart';

class PersonalOrderController {
  var server = 'https://nodeapi.projectkitaid.com/transaksi';

  Future<ResponseModels?> sendOrderInformation(
      {required String nama,
      required String norwo,
      required String statusPengisian,
      required String statusTransaksi,
      required String idTabung,
      required String spesifikasiTabung,
      required String image,
      required String kebutuhan,
      required String nominal}) async {
    try {
      Map<String, dynamic> body = {
        "nama": nama,
        "rwo": norwo,
        "status_pengisian": statusPengisian,
        "status_transaksi": statusTransaksi,
        "idTabung": idTabung,
        "spesifikasi_tabung": spesifikasiTabung,
        "image": image,
        "kebutuhan": kebutuhan,
        "nominal": nominal
      };
      print((body));
      final resp = await http.post(Uri.parse('$server/upload-transaction'),
          headers: {"content-type": "application/x-www-form-urlencoded"},
          body: (body));

      return ResponseModels.fromJson(jsonDecode(resp.body));
    } catch (e) {
      return ResponseModels(resp: false, msj: e.toString());
    }
  }
}

class PersonalStatusController {
  var server = 'https://nodeapi.projectkitaid.com/transaksi';

  Future<ResponseModels?> orderStatusInformation(
      {required String nama, required String rwo}) async {
    final body = {
      "nama": nama,
      "rwo": rwo,
    };
    print(body);
    final resp = await http.post(
      Uri.parse('$server/transaction-status'),
      headers: {"content-type": "application/x-www-form-urlencoded"},
      body: (body),
    );

    return ResponseModels.fromJson(jsonDecode(resp.body));
  }
}

final orderController = PersonalOrderController();
final statusController = PersonalStatusController();
