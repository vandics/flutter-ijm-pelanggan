import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app_ijm_pelanggan/controller/ordercontroller.dart';
import 'package:mobile_app_ijm_pelanggan/models/productmodels.dart';

part 'tracking_event.dart';

part 'tracking_state.dart';

class TrackingBloc extends Bloc<TrackingEvent, TrackingState> {
  TrackingBloc() : super(TrackingState(products: [], nama: ''));

  List<ProductCart> product = [];
  String status = '';

  @override
  Stream<TrackingState> mapEventToState(TrackingEvent event) async* {
    if (event is AddProductToTrackingEvent) {
      if (product.length != 0) {
        product.clear();
      }
      final map = event.product.asMap();
      product = map.values.toList();
      double sum = 0;
      double pricee = 0;
      product.forEach((element) {
        sum = sum + (element.price * element.amount);
        pricee = element.price;
      });

      yield state.copyWith(
          nama: event.nama,
          products: product,
          total: sum,
          price: pricee,
          amount: 0,
          status: event.status,
          rwo: event.rwo);
    } else if (event is TrackingNotificationEvent) {
      yield* __mapTrackingNotification(event.nama, event.rwo);
    }
  }

  Stream<TrackingState> __mapTrackingNotification(
      String nama, String rwo) async* {
    try {
      final data =
          await statusController.orderStatusInformation(nama: nama, rwo: rwo);
      print(data!.msj);
      if (data.msj == 'Sedang diproses') {
        yield ProcessState();

        double sum = 0;
        double pricee = 0;
        product.forEach((element) {
          sum = sum + (element.price * element.amount);
          pricee = element.price;
        });
        yield state.copyWith(
            nama: nama,
            products: product,
            total: sum,
            price: pricee,
            amount: 0,
            status: status,
            rwo: rwo);
      } else if (data.msj == 'Sedang diisi') {
        yield FillState();
        double sum = 0;
        double pricee = 0;
        product.forEach((element) {
          sum = sum + (element.price * element.amount);
          pricee = element.price;
        });
        yield state.copyWith(
            nama: nama,
            products: product,
            total: sum,
            price: pricee,
            amount: 0,
            status: status,
            rwo: rwo);
      } else if (data.msj == 'Selesai diisi') {
        yield ReadyState();
        double sum = 0;
        double pricee = 0;
        product.forEach((element) {
          sum = sum + (element.price * element.amount);
          pricee = element.price;
        });
        yield state.copyWith(
            nama: nama,
            products: product,
            total: sum,
            price: pricee,
            amount: 0,
            status: status,
            rwo: rwo);
      } else if (data.msj == 'Sedang diantar') {
        yield DeliveryState();
        double sum = 0;
        double pricee = 0;
        product.forEach((element) {
          sum = sum + (element.price * element.amount);
          pricee = element.price;
        });
        yield state.copyWith(
            nama: nama,
            products: product,
            total: sum,
            price: pricee,
            amount: 0,
            status: status,
            rwo: rwo);
      }
    } catch (e) {
      print('error');
    }
  }
}
