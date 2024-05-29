import 'package:blinking_text/blinking_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/providers/authenprovider.dart';
import 'package:th.ac.ru.uSmart/providers/schedule_provider.dart';
import 'package:th.ac.ru.uSmart/schedule/schedule_home_screen.dart';
import 'package:th.ac.ru.uSmart/utils/custom_functions.dart';

class ScheduleHome extends StatefulWidget {
  const ScheduleHome({super.key});

  @override
  State<ScheduleHome> createState() => _ScheduleHomeState();
}

class _ScheduleHomeState extends State<ScheduleHome> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ScheduleProvider, AuthenProvider>(
      builder: (context, scheduleProvider, authenProvider, _) {
        // authenProvider.getProfile();
        //scheduleProvider.fetchSchedules();
        return scheduleProvider.isLoading
            ? CircularProgressIndicator()
            : ListView.builder(
                key: Key('listSchedules'),
                padding: const EdgeInsets.all(1),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: scheduleProvider.schedules.length > 0 ? 1 : 0,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: ListTile(
                        title: Text(
                          '${formatDate(scheduleProvider.schedules[0].startDate)} - ${formatDate(scheduleProvider.schedules[0].endDate)}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        subtitle: Text(
                          '${scheduleProvider.schedules[0].eventName}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        // trailing: Text(
                        //   ' ${commingTime(DateTime.parse(scheduleProvider.schedules[0].startDate), DateTime.now(), DateTime.parse(scheduleProvider.schedules[0].endDate))}',
                        //   style: TextStyle(
                        //       color: Colors.redAccent,
                        //       fontSize: 12,
                        //       fontStyle: FontStyle.italic),
                        // ),
                        trailing: BlinkText(
                            '${commingTimeNewLine(DateTime.parse(scheduleProvider.schedules[0].startDate), DateTime.now(), DateTime.parse(scheduleProvider.schedules[0].endDate))}',
                            style: TextStyle(
                                fontSize: 12, fontStyle: FontStyle.italic),
                            beginColor: Colors.redAccent,
                            endColor: Colors.red
                                .shade50), //                             trailing: BlinkText(

                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ScheduleHomeScreen()),
                          );
                        },
                        leading: Icon(
                          Icons.timer,
                          // color: Colors.lightBlue,
                        ),
                      ),
                    ),
                  );
                },
              );
      },
    );
  }
}
