import 'dart:convert';

Databasetransaksi databasetransaksiFromJson(String str) =>
    Databasetransaksi.fromJson(json.decode((str)));

class Databasetransaksi {
  bool resp;
  List<Information> information;

  Databasetransaksi({required this.resp, required this.information});

  factory Databasetransaksi.fromJson(Map<String, dynamic> parsedjson) {
    var info = parsedjson["information"] as List;
    print(info.runtimeType);
    List<Information> information =
        info.map((e) => Information.fromJson(e)).toList();
    return Databasetransaksi(
      resp: parsedjson["resp"],
      information: information,
    );
  }
}

class Information {
  String rwo;
  String statustransaksi;
  String dateTime;
  String productcart;

  Information(
      {required this.rwo,
      required this.statustransaksi,
      required this.dateTime,
      required this.productcart});

  factory Information.fromJson(Map<String, dynamic> parsedjson) {
    var kebutuhan = parsedjson["kebutuhan"];
    var rwo = parsedjson["rwo"];
    var status = parsedjson["status_transaksi"];
    var datetime = parsedjson["created"];

    return Information(
        rwo: rwo,
        productcart: kebutuhan,
        statustransaksi: status,
        dateTime: datetime);
  }
}
