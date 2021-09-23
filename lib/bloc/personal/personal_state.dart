part of 'personal_bloc.dart';

class PersonalInformationState {
  final String nama;
  final String alamat;
  final String username;
  final int numreq;
  PersonalInformationState(
      {this.nama = '', this.alamat = '', this.username = '', this.numreq = 0});

  PersonalInformationState copyWith(
          {required String nama,
          required String alamat,
          required String username,
          int numreq = 0}) =>
      PersonalInformationState(
          nama: nama, alamat: alamat, username: username, numreq: numreq);
}

class FailureInformationState extends PersonalInformationState {
  final String error;

  FailureInformationState({required this.error});
}

class PersonalOrderState {}

class SuccesOrderState extends PersonalOrderState {}

class FailureOrderState extends PersonalOrderState {
  final String error;

  FailureOrderState({required this.error});
}
