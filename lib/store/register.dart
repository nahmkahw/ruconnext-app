import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/register_model.dart';

class RegisterStorage {
  static const String key = 'register';

  static Future<void> saveRegister(Register register) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final registerJson = register.toJson();
    await prefs.setString(key, jsonEncode(registerJson));
  }

  static Future<Register> getRegister() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final registerString = prefs.getString(key);
    if (registerString != null) {
      final registerJson = jsonDecode(registerString);
      return Register.fromJson(registerJson);
    }
    return Register();
  }

  static Future<void> removeRegister() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, '');
  }
}
