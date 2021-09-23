import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app_ijm_pelanggan/controller/imagecontroller.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageState());

  @override
  Stream<ImageState> mapEventToState(ImageEvent event) async* {
    if (event is UploadImageTransactionEvent) {
      yield* _mapUploadImageTransaction(
          event.image, event.rwo, event.nama, event.nomor);
    } else if (event is UploadImageTabungEvent) {
      yield* _mapUploadImageTabung(
          event.image, event.namaTabung, event.status, event.namaUser);
    }
  }

  Stream<ImageState> _mapUploadImageTransaction(
      String image, String rwo, String nama, String nomor) async* {
    try {
      yield LoadingUploadImageState();

      final resp = await uploadImageController.uploadImageTransaction(
          image, rwo, nama, nomor);

      yield UploadImageSuccess();

      yield state.copyWith(image: resp.image);
    } catch (e) {
      yield FailUploadImage(error: e.toString());
    }
  }

  Stream<ImageState> _mapUploadImageTabung(
      String image, String nama, String status, String namaUser) async* {
    try {
      print(nama);
      yield LoadingUploadImageState();

      final resp = await uploadImageController.uploadImageTabung(
          image, nama, status, namaUser);

      yield UploadImageSuccess();

      yield state.copyWith(image: resp.image);
    } catch (e) {
      yield FailUploadImage(error: e.toString());
    }
  }
}
