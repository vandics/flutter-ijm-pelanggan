part of 'tracking_bloc.dart';

class TrackingState {
  List<ProductCart> products = [];
  final double total;
  final double price;
  final int amount;
  final String status;
  final String rwo;
  final String nama;
  final String statusPengisian;

  TrackingState(
      {this.products = const [],
      this.rwo = '',
      this.amount = 0,
      this.price = 0,
      this.status = '',
      this.statusPengisian = '',
      this.total = 0,
      this.nama = ''});

  TrackingState copyWith(
          {required List<ProductCart> products,
          required double total,
          required double price,
          required int amount,
          required String status,
          required String rwo,
          required String nama}) =>
      TrackingState(
        nama: nama,
        products: products,
        amount: amount,
        price: price,
        status: status,
        total: total,
        rwo: rwo,
      );
}

class ProcessState extends TrackingState {}

class FillState extends TrackingState {}

class ReadyState extends TrackingState {}

class DeliveryState extends TrackingState {}
