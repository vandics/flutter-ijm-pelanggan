import 'dart:convert';

PersonalInformationResponse personalInformationResponseFromJson(String str) =>
    PersonalInformationResponse.fromJson(json.decode((str)));

String personalInformationResponseToJson(PersonalInformationResponse data) =>
    json.encode(data.toJson());

class PersonalInformationResponse {
  bool resp;
  String msj;
  Information information;

  PersonalInformationResponse({
    required this.resp,
    required this.msj,
    required this.information,
  });

  factory PersonalInformationResponse.fromJson(Map<String, dynamic> json) =>
      PersonalInformationResponse(
        resp: json["resp"],
        msj: json["msj"],
        information: Information.fromJson(json["information"]),
      );

  Map<String, dynamic> toJson() => {
        "resp": resp,
        "msj": msj,
        "information": information.toJson(),
      };
}

class Information {
  String nama;
  String alamat;
  String username;
  String instansi;
  String telpon;
  int nomorpesan;

  Information(
      {required this.nama,
      required this.alamat,
      required this.instansi,
      required this.username,
      required this.telpon,
      required this.nomorpesan});

  factory Information.fromJson(Map<String, dynamic> json) => Information(
      nama: json["nama"],
      alamat: json["alamat"],
      instansi: json["instansi"],
      username: json["username"],
      telpon: json["telepon"],
      nomorpesan: json["nomor_pesan"]);

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "alamat": alamat,
        "instansi": instansi,
        "username": username,
        "telpon": telpon,
        "nomor_pesan": nomorpesan
      };
}

OrderInformationResponse orderInformationResponseFromJson(String str) =>
    OrderInformationResponse.fromJson(json.decode(str));

String orderInformationResponseToJson(OrderInformationResponse data) =>
    json.encode(data.toJson());

class OrderInformationResponse {
  bool resp;
  String msj;
  Information informationOrder;

  OrderInformationResponse({
    required this.resp,
    required this.msj,
    required this.informationOrder,
  });

  factory OrderInformationResponse.fromJson(Map<String, dynamic> json) =>
      OrderInformationResponse(
        resp: json["resp"],
        msj: json["msj"],
        informationOrder: Information.fromJson(json["informationOrder"]),
      );

  Map<String, dynamic> toJson() => {
        "resp": resp,
        "msj": msj,
        "informationOrder": informationOrder.toJson(),
      };
}

String informationOrderToJson(InformationOrder data) =>
    json.encode(data.toJson());

class InformationOrder {
  final String nama;
  final String norwo;
  final String statusPengisian;
  final String statusTransaksi;
  final String idTabung;
  final String spesifikasiTabung;
  final String image;
  final String kebutuhan;
  final double nominal;

  InformationOrder(
      {required this.nama,
      required this.norwo,
      required this.statusPengisian,
      required this.statusTransaksi,
      required this.idTabung,
      required this.spesifikasiTabung,
      required this.image,
      required this.kebutuhan,
      required this.nominal});

  factory InformationOrder.fromJson(Map<String, dynamic> json) =>
      InformationOrder(
          nama: json["nama"],
          norwo: json["norwo"],
          statusPengisian: json["statusPengisian"],
          statusTransaksi: json["statusTransaksi"],
          idTabung: json["idTabung"],
          spesifikasiTabung: json["spesifikasiTabung"],
          image: json["image"],
          kebutuhan: json["kebutuhan"],
          nominal: json["nominal"]);

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "norwo": norwo,
        "statusPengisian": statusPengisian,
        "statusTransaksi": statusTransaksi,
        "idTabung": idTabung,
        "spesifikasiTabung": spesifikasiTabung,
        "image": image,
        "kebutuhan": kebutuhan,
        "nominal": nominal
      };
}
