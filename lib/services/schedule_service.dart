import 'package:dio/dio.dart';
import '../model/schedule.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ScheduleService {
  final calendarurl = dotenv.env['CALENDAR_URL'];
  Future<List<Schedule>> getSchedules() async {
    List<Schedule> listSchedule = [];
    //print('Call Service schedule');
    try {
      Response response = await Dio().get(
          '$calendarurl/CalendarCenter/ScheduleCenterFlutter');
      if (response.statusCode == 200) {
         List<dynamic> data = response.data;
        listSchedule = data.map((json) => Schedule.fromJson(json)).toList();
      } else {
        throw ('Error Get Year Semester.');
      }
    } catch (error) {
      throw error;
    }

    return listSchedule;
  }
}
