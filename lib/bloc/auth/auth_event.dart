part of 'auth_bloc.dart';

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;

  LoginEvent({required this.username, required this.password});
}

class LogOutEvent extends AuthEvent {}

class CheckLoginEvent extends AuthEvent {}

class RegisterEvent extends AuthEvent {
  final String username;
  final String nama;
  final String password;
  final String telpon;
  final String alamat;
  final String instansi;

  RegisterEvent({
    required this.instansi,
    required this.nama,
    required this.username,
    required this.password,
    required this.alamat,
    required this.telpon,
  });
}

class UploadImageEvent extends AuthEvent {
  final String image;

  UploadImageEvent({required this.image});
}
