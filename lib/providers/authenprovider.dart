import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/store/mr30.dart';
import '../services/authenservice.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../model/profile.dart';
import '../store/profile.dart';

class AuthenProvider extends ChangeNotifier {
  final _googleSingIn = GoogleSignIn();
  final AuthenService _service;

  AuthenProvider({required AuthenService service}) : _service = service;

  bool isLoading = false;
  bool get loading => isLoading;

  Profile _profile = Profile(studentCode: "");
  Profile get profile => _profile;

  String _role = "-";
  String get role => _role;

  Future<void> login(context) async {
    isLoading = true;

    try {
      isLoading = false;
      _profile = await _service.getAuthenGoogle();
      await ProfileStorage.saveProfile(_profile);
      Get.offNamedUntil('/', (route) => true);
    } catch (e) {
      await _googleSingIn.signOut();
      isLoading = false;
      var snackbar = SnackBar(content: Text('$e'));
      print('$e');
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }

    notifyListeners();
  }

  Future<void> logintest(context, studentcode) async {
    isLoading = true;

    try {
      _profile = await _service.getAuthenGoogleTest(studentcode);
      await ProfileStorage.saveProfile(_profile);
      Get.offNamedUntil('/', (route) => true);
    } catch (e) {
      await _googleSingIn.signOut();
      var snackbar = SnackBar(content: Text('$e'));
      //print('$e');
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    _profile = new Profile(studentCode: "");
    await ProfileStorage.removeProfile();
    await MR30Storage.removeMR30();
    await _googleSingIn.signOut();

    Get.offNamedUntil('/', (route) => true);
    notifyListeners();
  }

  Future<void> getProfile() async {
    await Future<dynamic>.delayed(const Duration(seconds: 1));
    _profile = await ProfileStorage.getProfile();
    print('Profile');
    try {
      Map<String, dynamic> decodedToken =
          JwtDecoder.decode(profile.accessToken.toString());
      // Now you can use your decoded token
      _role = decodedToken["role"];
    } catch (e) {
      print('Error decoding JWT: $e');
      _role = '-';
    }
    isLoading = false;
    notifyListeners();
  }
}
