part of 'tracking_bloc.dart';

abstract class TrackingEvent {}

class AddProductToTrackingEvent extends TrackingEvent {
  final List<ProductCart> product;
  final String status;
  final String rwo;
  final String nama;

  AddProductToTrackingEvent({
    required this.product,
    required this.status,
    required this.rwo,
    required this.nama,
  });
}

class TrackingNotificationEvent extends TrackingEvent {
  final String nama;
  final String rwo;

  TrackingNotificationEvent({required this.nama, required this.rwo});
}
