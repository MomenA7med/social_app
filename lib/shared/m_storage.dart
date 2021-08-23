import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

MStorage mStorage = MStorage._private();

class MStorage {
  SharedPreferences prefs;
  Future<void> initialize() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> logOut(String key) async {
    return await prefs.remove(key);
  }

  String getToken(key) {
    return prefs.getString(key);
  }

  Future<void> setToken(String key, String value) async {
    await prefs.setString(key, value);
  }

  MStorage._private();
}
