import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_app_ijm_pelanggan/controller/authcontroller.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LoginEvent) {
      yield* _mapAuthenticationLogin(event.username, event.password);
    } else if (event is CheckLoginEvent) {
      yield* _mapCheckAuthentication();
    } else if (event is RegisterEvent) {
      yield* _mapAuthenticationRegister(event.nama, event.alamat,
          event.username, event.password, event.instansi, event.telpon);
    }
  }

  Stream<AuthState> _mapAuthenticationLogin(
      String username, String password) async* {
    try {
      yield LoadingState();

      await Future.delayed(Duration(seconds: 2));

      final data =
          await authController.login(username: username, password: password);

      if (data.resp) {
        yield LogInState();

        yield state.copyWith(
          uid: data.users.id.toString(),
          username: data.users.users,
        );
      } else {
        yield FailureState(error: data.msj);
      }
    } catch (e) {
      yield FailureState(error: e.toString());
    }
  }

  Stream<AuthState> _mapAuthenticationRegister(String nama, String username,
      String password, String instansi, String alamat, String telpon) async* {
    try {
      yield LoadingRegisterState();

      await Future.delayed(Duration(seconds: 2));

      final data = await authController.createUser(
          nama: nama,
          username: username,
          telpon: telpon,
          alamat: alamat,
          instansi: instansi,
          password: password);

      if (data.resp)
        yield RegisterSuccess();
      else
        yield FailureRegisterState(error: data.msj);
    } catch (e) {
      FailureRegisterState(error: e.toString());
    }
  }

  Stream<AuthState> _mapCheckAuthentication() async* {
    final secureStorage = FlutterSecureStorage();

    final hasToken = await authController.hasToken();

    if (hasToken) {
      final data = await authController.renewToken();

      await Future.delayed(Duration(seconds: 1));

      if (data.resp) {
        yield LogInState();

        yield state.copyWith(
          uid: data.users.id.toString(),
          username: data.users.users,
        );
      } else {
        yield LogOutState();
        await secureStorage.deleteAll();
      }
    } else {
      yield LogOutState();
      await secureStorage.deleteAll();
    }
  }
}
