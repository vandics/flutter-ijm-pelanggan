part of 'auth_bloc.dart';

class AuthState {
  final String uid;
  final String username;

  AuthState({
    this.uid = '0',
    this.username = '--',
  });

  AuthState copyWith({
    required String uid,
    required String username,
  }) =>
      AuthState(
        uid: uid,
        username: username,
      );
}

// --------------------------------------------------//
class LogInState extends AuthState {}

class LogOutState extends AuthState {}

class LoadingState extends AuthState {}

class FailureState extends AuthState {
  final String error;

  FailureState({required this.error});
}

// -------------------------------------------------//
class LoadingRegisterState extends AuthState {}

class RegisterSuccess extends AuthState {}

class FailureRegisterState extends AuthState {
  final String error;

  FailureRegisterState({required this.error});
}
// -------------------------------------------------//

class LoadingImageState extends AuthState {}

class UploadImageSuccesState extends AuthState {}

class FailureUploadImageState extends AuthState {}
