import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static late SharedPreferences sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static bool getTheme() {
    return sharedPreferences.getBool("isDark") ?? false;
  }

  static Future<void> setTheme(bool isDark) async {
    await sharedPreferences.setBool("isDark", isDark);
  }

  static Future<String?> getLanguage() async {
    debugPrint('SharedPrefHelper :  get data  language');
    return sharedPreferences.getString("language");
  }

  static Future<void> setLanguage(String languageCode) async {
    debugPrint('SharedPrefHelper :set  data : language ');
    await sharedPreferences.setString("language", languageCode);
  }

  static int? getId() {
    return sharedPreferences.getInt('user_id');
  }

  static Future<void> setId(int id) async {
    debugPrint('SharedPrefHelper : set data id');
    await sharedPreferences.setInt('user_id', id);
  }

  Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  Future<bool> containsKey({required String key}) async {
    return sharedPreferences.containsKey(key);
  }

// clear all data
  Future<bool> clearData() async {
    return await sharedPreferences.clear();
  }
}
