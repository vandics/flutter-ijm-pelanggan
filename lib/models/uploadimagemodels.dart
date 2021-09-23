import 'dart:convert';

UploadImage uploadImageModelFromJson(String str) =>
    UploadImage.fromJson(json.decode(str));

String uploadImageModelToJson(UploadImage data) => json.encode(data.toJson());

class UploadImage {
  UploadImage({required this.resp, required this.msj, required this.image});

  bool resp;
  String msj;
  String image;

  factory UploadImage.fromJson(Map<String, dynamic> json) =>
      UploadImage(resp: json["resp"], msj: json["msj"], image: json["image"]);

  Map<String, dynamic> toJson() => {"resp": resp, "msj": msj, "profile": image};
}

DeleteImageModel deleteImageModelFromJson(String str) =>
    DeleteImageModel.fromJson(json.decode(str));

class DeleteImageModel {
  DeleteImageModel({required this.resp, required this.msj});

  bool resp;
  String msj;

  factory DeleteImageModel.fromJson(Map<String, dynamic> json) =>
      DeleteImageModel(resp: json["resp"], msj: json["msj"]);
}
