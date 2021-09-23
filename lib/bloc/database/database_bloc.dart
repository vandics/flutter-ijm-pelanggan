import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app_ijm_pelanggan/controller/databasecontroller.dart';
import 'package:mobile_app_ijm_pelanggan/models/databasemodel.dart';

part 'database_event.dart';

part 'database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  DatabaseBloc() : super(DatabaseState());
  List<Information> history = [];
  @override
  Stream<DatabaseState> mapEventToState(DatabaseEvent event) async* {
    if (event is HistoryEvent) {
      yield* _mapHistoryEvent(event.nama);
    }
  }

  Stream<DatabaseState> _mapHistoryEvent(String nama) async* {
    try {
      final resp = await databasecontroller.getDataTransasksi(nama);
      history = resp.information;

      yield state.copyWith(history: history);
    } catch (e) {
      yield state.copyWith(history: []);
    }
  }
}
