part of 'personal_bloc.dart';

abstract class PersonalEvent {}

class PersonalInformationEvent extends PersonalEvent {
  final String username;

  PersonalInformationEvent({required this.username});
}

class PersonalOrderEvent extends PersonalEvent {
  final String nama;
  final String norwo;
  final String statusPengisian;
  final String statusTransaksi;
  final String idTabung;
  final String spesifikasiTabung;
  final String image;
  final String kebutuhan;
  final String nominal;

  PersonalOrderEvent(
      {required this.nama,
      required this.norwo,
      required this.statusPengisian,
      required this.statusTransaksi,
      required this.idTabung,
      required this.spesifikasiTabung,
      required this.image,
      required this.kebutuhan,
      required this.nominal});
}
