import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../exceptions/dioexception.dart';
import '../model/profile.dart';
import '../model/rutoken.dart';

class AuthenService {
  final appUrl = dotenv.env['APP_URL_DEV'];
  final googleSingIn = GoogleSignIn();

  Future<Profile> getAuthenGoogle() async {
    Profile profile;
    try {
      GoogleSignInAccount? user = await googleSingIn.signIn();
      print(user);
      GoogleSignInAuthentication usergoogle = await user!.authentication;
      print("-------------appUrl------------------- : $appUrl\n");
      print("-------------login success-------------------\n");
      print('accessToken : ${usergoogle.accessToken}\n');
      print('idToken: ${usergoogle.idToken}\n');
      String studentcode = user.email.substring(0, 10);
      var params = {"std_code": studentcode};
      var response = await Dio().post(
        '$appUrl/google/authorization',
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            "authorization": "Bearer ${usergoogle.idToken}",
          },
        ),
        data: jsonEncode(params),
      );

      if (response.statusCode == 200) {
        Rutoken token = Rutoken.fromJson(response.data);
        print("-------------ru authen success-------------------\n");
        print('response ${response.data}');
        print('rutoken : ${token.accessToken}');
        profile = Profile.fromJson({
          'displayName': user.displayName,
          'email': user.email,
          'studentCode': studentcode,
          'photoUrl': user.photoUrl,
          'googleToken': usergoogle.idToken,
          'accessToken': token.accessToken,
          'refreshToken': token.refreshToken,
          'isAuth': token.isAuth
        });
        print(profile.email);
        return profile;
      } else {
        print(response.statusCode);
        throw ('Error Authentication Ramkhamhaeng University.');
      }
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      //print('Error Authentication Ramkhamhaeng University: $errorMessage .');
      throw ('Error Authentication Ramkhamhaeng University: $errorMessage .');
    } catch (e) {
      // print('เกิดข้อผิดพลาดในการเชื่อมต่อ. $e');
      await googleSingIn.signOut();
      throw ('เกิดข้อผิดพลาดในการเชื่อมต่อ....... $e');
    }
  }

  Future<Profile> getAuthenGoogleTest(studentcode) async {
    Profile profile;
    try {
      var params = {"std_code": studentcode};
      var response = await Dio().post(
        '$appUrl/google/authorization-test',
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            "authorization": "Bearer ",
          },
        ),
        data: jsonEncode(params),
      );

      if (response.statusCode == 200) {
        Rutoken token = Rutoken.fromJson(response.data);
        // print("-------------ru authen success-------------------\n");
        // print('response ${response.data}');
        // print('rutoken : ${token.accessToken}');
        // profile = Profile.fromJson({
        //   'displayName': "6299999991",
        //   'email': "6299999991@rumail.ru.ac.th",
        //   'studentCode': studentcode,
        //   'photoUrl': '',
        //   'googleToken': '',
        //   'accessToken': token.accessToken,
        //   'refreshToken': token.refreshToken,
        //   'isAuth': token.isAuth
        // });
        profile = Profile.fromJson({
          'displayName': 'user.displayName',
          'email': 'user.email',
          'studentCode': studentcode,
          'photoUrl':
              'https://lh3.googleusercontent.com/a/ACg8ocKpV0cNH9ui8Sa5ZcayECbF4bqOPyRtH5MVsbqCkW_mXaKHVQOSpw=s288-c-no',
          'googleToken': 'usergoogle.idToken',
          'accessToken': token.accessToken,
          'refreshToken': token.refreshToken,
          'isAuth': token.isAuth
        });
        // print(profile.email);
        return profile;
      } else {
        throw ('Error Authentication Ramkhamhaeng University.');
      }
    } on DioError catch (err) {
      final errorMessage = DioException.fromDioError(err).toString();
      //print('Error Authentication Ramkhamhaeng University: $errorMessage .');
      throw ('Error Authentication Ramkhamhaeng University: $errorMessage .');
    } catch (e) {
      // print('เกิดข้อผิดพลาดในการเชื่อมต่อ. $e');
      throw ('เกิดข้อผิดพลาดในการเชื่อมต่อ. $e');
    }
  }
}
