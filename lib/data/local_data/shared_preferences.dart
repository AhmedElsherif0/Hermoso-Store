import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPreferences? _sharedPreferences;

  static init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool?> saveStringData(
      {required String key, required String? value}) async {
    return await _sharedPreferences?.setString(key, value ?? '') ?? false;
  }

  static Future<bool?> saveData({required String key, dynamic value}) async {
    if (value is bool) {
      return await _sharedPreferences?.setBool(key, value) ?? false;
    } else if (value is String) {
      return await _sharedPreferences?.setString(key, value) ?? false;
    } else if (value is int) {
      return await _sharedPreferences?.setInt(key, value) ?? false;
    }

    return await _sharedPreferences?.setDouble(key, value) ?? false;
  }

  static Future<bool?> saveBoolData(
      {required String key, required bool value}) async {
    return await _sharedPreferences?.setBool(key, value) ?? false;
  }

  static Future<bool?> saveDoubleData(
      {required String key, required double value}) async {
    return await _sharedPreferences?.setDouble(key, value) ?? false;
  }

  static dynamic getData({required String key}) async {
    return _sharedPreferences?.get(key) ;
  }

  static dynamic getBoolData({required dynamic key}) async {
    return _sharedPreferences?.getBool(key) ?? false;
  }

  static Future<bool?> removeData({required String key}) async {
    return await _sharedPreferences?.remove(key) ?? false;
  }
}
