part of 'database_bloc.dart';

abstract class DatabaseEvent {}

class HistoryEvent extends DatabaseEvent {
  final String nama;

  HistoryEvent({required this.nama});
}
