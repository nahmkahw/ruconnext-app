import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/grade_model.dart';

class GradeStorage {
  static const String key = 'grade';

  static Future<void> saveGrade(Grade grade) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final gradeJson = grade.toJson();
    await prefs.setString(key, jsonEncode(gradeJson));
  }

  static Future<Grade> getGrade() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final gradeString = prefs.getString(key);
    if (gradeString != null) {
      final gradeJson = jsonDecode(gradeString);
      return Grade.fromJson(gradeJson);
    }
    return Grade();
  }

  static Future<void> removeGrade() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, '');
  }
}
