// import 'dart:convert';

// import 'package:dio/dio.dart';
import 'package:th.ac.ru.uSmart/model/ruregis_model.dart';
import 'package:th.ac.ru.uSmart/services/ruregis_service.dart';
import 'package:flutter/material.dart';

// import 'package:shared_preferences/shared_preferences.dart';

// import '../exceptions/dioexception.dart';

class RuregisProvider extends ChangeNotifier {
   final  _ruregisService = RuregisService();

    // List<Ruregis> _ruregis = [];
  String _error = '';
  String get error => _error;

  bool isLoading = false;

  // List<Ruregis> get ruregis => _ruregis;

  Ruregis _ruregis = Ruregis();
  Ruregis get ruregis => _ruregis;

  //   Future<void> fetchProfileRuregis2() async {
  //   isLoading = true;
  //   try {
  //     List<Ruregis> ruregis = await _ruregisService.getProfileRuregis();
  //     _ruregis = ruregis;
  //     print('data ruregis $_ruregis');
  //     isLoading = false;
  //   } catch (error) {
  //     print(error);
  //     isLoading = false;
  //     notifyListeners();
  //   }
  // }

   Future<void> fetchProfileRuregis() async {
    isLoading = true;
    _error = '';

    notifyListeners();
    try {
      final response = await _ruregisService.getProfileRuregis();
      _ruregis = response ;
      print(_ruregis);
    } on Exception catch (e) {
      isLoading = false;
      _error = 'เกิดข้อผิดพลาดดึงข้อมูลนักศึกษา';
    }

    //await _service.asyncName();

    isLoading = false;
    notifyListeners();
  }
}
