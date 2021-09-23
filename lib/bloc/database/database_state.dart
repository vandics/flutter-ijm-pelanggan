part of 'database_bloc.dart';

class DatabaseState {
  List<Information> history;

  DatabaseState({this.history = const []});

  DatabaseState copyWith({required List<Information> history}) =>
      DatabaseState(history: history);
}
