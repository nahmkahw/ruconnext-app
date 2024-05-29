// ignore_for_file: non_constant_identifier_names

import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/hotel_booking/model/hotel_list_data.dart';
import 'package:th.ac.ru.uSmart/providers/schedule_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/widget/Rubar.dart';
import '../hotel_booking/hotel_app_theme.dart';
import '../providers/ruregis_provider.dart';

class RuRegisHomeScreen extends StatefulWidget {
  @override
  _RuRegisHomeScreenState createState() => _RuRegisHomeScreenState();
}

class _RuRegisHomeScreenState extends State<RuRegisHomeScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<HotelListData> hotelList = HotelListData.hotelList;
  final ScrollController _scrollController = ScrollController();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
    
    //Provider.of<RuregisProvider>(context, listen: false).fetchRuregis();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //context.read<RuregisProvider>().getAllRuregis();

    // var mr30 = context.watch<MR30Provider>();
    var scheduleProv = context.watch<ScheduleProvider>();
    return Theme(
      data: HotelAppTheme.buildLightTheme(),
      child: Container(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  children: <Widget>[
                    getAppBarUI(),
                    Expanded(
                      child: ProfileCard(),
                    ),
                    Expanded(
                      child: Text(''),
                    ),
                    Expanded(
                      child: Text(''),
                    ),
                    Expanded(
                      child: Text(''),
                    )
                    
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ProfileCard() {
    return Container(
        width: 800.0, // Set the desired width
        height: 50.0, //
        child: Card(
          margin: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/ID.png'),
                ),
                title: Text(
                  'น.ส.เปลวเทียน รักเรียน',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                subtitle: Text('คณะนิติศาสตร์ สาขานิติศาสตร์'),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16.0, 10.0, 5.0, 5.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning, // Replace with the desired icon
                      color: Colors.red, // Customize the icon color if needed
                    ),
                    SizedBox(
                        width: 8.0), // Add some space between the icon and text
                    Text(
                      'รหัสนักศึกษานี้ไม่ใช่นักศึกษาส่วนกลางหรือเป็นนักศึกษาโครงการพิเศษ ไม่สามารถลงทะเบียนได้',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16.0, 5.0, 5.0, 5.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning, // Replace with the desired icon
                      color: Colors.red, // Customize the icon color if needed
                    ),
                    SizedBox(
                        width: 8.0), // Add some space between the icon and text
                    Text(
                      'นักศึกษาทุน 5G',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
                            Padding(
                padding: EdgeInsets.fromLTRB(16.0, 5.0, 5.0, 5.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning, // Replace with the desired icon
                      color: Colors.red, // Customize the icon color if needed
                    ),
                    SizedBox(
                        width: 8.0), // Add some space between the icon and text
                    Text(
                      'ไม่ได้ลงทะเบียนเรียน 2 ภาคการศึกษา',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.background,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 0,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Rubar(textTitle: 'ลงทะเบียนเรียนปริญญาตรีส่วนกลาง'),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
              ),
            )
          ],
        ),
      ),
    );
  }
}
