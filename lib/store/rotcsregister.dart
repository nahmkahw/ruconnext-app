import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:th.ac.ru.uSmart/model/rotcs_register.dart';

class RotcsRegisterStorage {
  static const String key = 'rotcsregister';

  static Future<void> saveRegister(RotcsRegister register) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final registerJson = register.toJson();
    await prefs.setString(key, jsonEncode(registerJson));
  }

  static Future<RotcsRegister> getRegister() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final registerString = prefs.getString(key);
    if (registerString != null) {
      final registerJson = jsonDecode(registerString);
      return RotcsRegister.fromJson(registerJson);
    }

    return RotcsRegister();
  }

  static Future<void> removeRegister() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, '{}');
  }
}
