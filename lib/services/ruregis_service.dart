import 'package:dio/dio.dart';
import '../model/ruregis_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'diointercepter.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/model/mr30_catalog.dart';
import 'package:th.ac.ru.uSmart/model/student.dart';
import 'package:th.ac.ru.uSmart/services/diointercepter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../model/profile.dart';
import '../store/profile.dart';
class RuregisService {
  final dioapi = DioIntercepter();
  final ruregisurl = dotenv.env['RUREGIS_API'];
    final appUrl = dotenv.env['APP_URL_DEV'];
  Future<List<Ruregis>> getProfileRuregis2() async {
    //print('Call Service Ruregis');
    try {
      Response response = await Dio().get(
          '$ruregisurl/profileApp.jsp?STUDENTID=6299999991');
      List<dynamic> data = response.data;
      print(response.data);
      return data.map((json) => Ruregis.fromJson(json)).toList();
    } catch (error) {
      throw error;
    }
  }

  Future<Ruregis> getProfileRuregis1() async {
    Ruregis ruregisdata = Ruregis.fromJson({});
    try {
      Profile profile = await ProfileStorage.getProfile();
      await dioapi.createIntercepter();
      print('token ' + '${profile.accessToken}');
      var response = await dioapi.api.get('$appUrl/student/profile',
          options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              "authorization": "Bearer ${profile.accessToken}",
            },
          ));
      if (response.statusCode == 200) {
       // print('data ${response}');
        ruregisdata = Ruregis.fromJson(response.data);
        //print('data ${ruregisdata}');
      } else {
        throw ('Error Get Data');
      }
    } catch (err) {
      print(err);
      throw (err);
    }

    return ruregisdata;
  }
  Future<Ruregis> getProfileRuregis() async {
    Ruregis ruregisdata = Ruregis.fromJson({});
    try {
      await dioapi.createIntercepter();
      var response = await dioapi.api.get('$ruregisurl/profileApp.jsp?STUDENTID=6601602904',
         );
      if (response.statusCode == 200) {
             print('data ${response.data}');

        ruregisdata = Ruregis.fromJson(response.data);
        print('data ${ruregisdata}');

      } else {
        throw ('Error Get Data');
      }
    } catch (err) {
      print(err);
      throw (err);
    }

    return ruregisdata;
  }
}
  