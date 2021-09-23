import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app_ijm_pelanggan/controller/ordercontroller.dart';
import 'package:mobile_app_ijm_pelanggan/controller/personalcontroller.dart';

part 'personal_event.dart';
part 'personal_state.dart';

class PersonalBloc
    extends Bloc<PersonalInformationEvent, PersonalInformationState> {
  PersonalBloc()
      : super(PersonalInformationState(alamat: '', nama: '', username: ''));

  @override
  Stream<PersonalInformationState> mapEventToState(
      PersonalInformationEvent event) async* {
    if (event is PersonalInformationEvent) {
      yield* _mapPersonalInformation(event.username);
    }
  }

  Stream<PersonalInformationState> _mapPersonalInformation(
      String username) async* {
    try {
      final resp =
          await personalController.getPersonalInformation(username: username);

      if (resp.resp == true) {
        yield state.copyWith(
          numreq: resp.information.nomorpesan,
          nama: resp.information.nama,
          alamat: resp.information.alamat,
          username: resp.information.username,
        );
      } else {
        yield FailureInformationState(error: 'data tidak berhasil didapatkan');
      }
    } catch (e) {
      yield FailureInformationState(error: e.toString());
    }
  }
}

class PersonalOrderBloc extends Bloc<PersonalOrderEvent, PersonalOrderState> {
  PersonalOrderBloc() : super(PersonalOrderState());

  @override
  Stream<PersonalOrderState> mapEventToState(PersonalOrderEvent event) async* {
    if (event is PersonalOrderEvent) {
      yield* _mapSendOrder(
        event.nama,
        event.norwo,
        event.statusPengisian,
        event.statusTransaksi,
        event.idTabung,
        event.spesifikasiTabung,
        event.image,
        event.kebutuhan,
        event.nominal,
      );
    }
  }

  Stream<PersonalOrderState> _mapSendOrder(
      String nama,
      String norwo,
      String statusPengisian,
      String statusTransaksi,
      String idTabung,
      String spesifikasiTabung,
      String image,
      String kebutuhan,
      String nominal) async* {
    try {
      final resp = orderController.sendOrderInformation(
        nama: nama,
        norwo: norwo,
        statusPengisian: statusPengisian,
        statusTransaksi: statusTransaksi,
        idTabung: idTabung,
        spesifikasiTabung: spesifikasiTabung,
        image: image,
        kebutuhan: kebutuhan,
        nominal: nominal,
      );
      yield SuccesOrderState();
    } catch (e) {
      FailureOrderState(error: e.toString());
    }
  }
}
