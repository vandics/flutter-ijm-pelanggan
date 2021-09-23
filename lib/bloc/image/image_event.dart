part of 'image_bloc.dart';

abstract class ImageEvent {}

class UploadImageTransactionEvent extends ImageEvent {
  final String image, rwo, nama, nomor;

  UploadImageTransactionEvent({
    required this.image,
    required this.rwo,
    required this.nama,
    required this.nomor,
  });
}

class UploadImageTabungEvent extends ImageEvent {
  final String image, namaTabung, status, namaUser;

  UploadImageTabungEvent({
    required this.image,
    required this.namaTabung,
    required this.status,
    required this.namaUser,
  });
}

class DeleteImageTabungEvent extends ImageEvent {
  final String namaTabung;

  DeleteImageTabungEvent({required this.namaTabung});
}
