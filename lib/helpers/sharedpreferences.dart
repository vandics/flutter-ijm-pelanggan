import 'package:shared_preferences/shared_preferences.dart';

class NumReqPreferences {
  static SharedPreferences? _preferences;

  static const _numOrder = 'numOrder ';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setnumOrder(int numOrder) async =>
      await _preferences!.setInt(_numOrder, 0);

  static int? getnumOrder() => _preferences!.getInt(_numOrder);
}

class NumStatus {
  static SharedPreferences? _preferences;

  static const _numStatus = 'numStatus ';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setnumOrder(int numOrder) async =>
      await _preferences!.setInt(_numStatus, 1);

  static int? getnumOrder() => _preferences!.getInt(_numStatus);
}
