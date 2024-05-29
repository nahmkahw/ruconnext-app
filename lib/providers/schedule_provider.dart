import 'package:flutter/foundation.dart';

import '../model/schedule.dart';
import '../services/schedule_service.dart';

class ScheduleProvider with ChangeNotifier {
  final ScheduleService _service;

  ScheduleProvider({required ScheduleService service}) : _service = service {
    //_loadFromSharedPreferences();
  }

  List<Schedule> _schedules = [];
  bool isLoading = false;

  List<Schedule> get schedules => _schedules;

  void fetchSchedules() async {
    isLoading = true;
    try {
      List<Schedule> schedules = await _service.getSchedules();
      _schedules = schedules;
      //print('data schedules $_schedules');
      isLoading = false;
    } catch (error) {
      //print(error);
      isLoading = false;
    }
    notifyListeners();
  }
}
