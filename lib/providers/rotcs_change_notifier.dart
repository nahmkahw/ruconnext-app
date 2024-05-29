import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/model/article.dart';
import 'package:th.ac.ru.uSmart/services/rotcsservice.dart';
import '../model/rotcs_register.dart';

class RotcsChangeNotifier extends ChangeNotifier {
  final RotcsService _service;

  RotcsChangeNotifier({required RotcsService service}) : _service = service;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  RotcsRegister _rotcsregister =
      RotcsRegister.fromJson({'studentCode': '', 'total': 0, 'detail': []});
  RotcsRegister get rotcsregister => _rotcsregister;

  String _rotcserror = '';
  String get rotcserror => _rotcserror;

  Future<void> getAllRegister() async {
    //RotcsRegister rotcsregister = await RotcsRegisterStorage.getRegister();
    _isLoading = true;
    notifyListeners();

    _rotcsregister = await _service.getRegisterAll();

    _isLoading = false;
    notifyListeners();
  }
}
