import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPreferences? _sharedPreferences;

  static init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool?> saveStringData(
      {required String key, required String? value}) async {
    return await _sharedPreferences?.setString(key, value!);
  }

  static Future<bool?> saveData(
      {required String key, required dynamic value}) async {
    if (value is String) return await _sharedPreferences?.setString(key, value);
    if (value is double) return await _sharedPreferences?.setDouble(key, value);
    if (value is int) return await _sharedPreferences?.setInt(key, value);

    return await _sharedPreferences?.setBool(key, value);
  }

  static Future<bool?> saveDoubleData(
      {required String key, required double value}) async {
    return await _sharedPreferences?.setDouble(key, value) ?? false;
  }

  static dynamic getData({required String key})  {
    return _sharedPreferences?.get(key);
  }

  static dynamic getBoolData({required dynamic key})  {
    return _sharedPreferences?.getBool(key);
  }

  static Future<bool> removeData({required String key}) async {
    return await _sharedPreferences!.remove(key);
  }
}
