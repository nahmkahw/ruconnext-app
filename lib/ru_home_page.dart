import 'package:blinking_text/blinking_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/model/homelist.dart';
import 'package:th.ac.ru.uSmart/model/schedule.dart';
import 'package:th.ac.ru.uSmart/pages/home_image_slider.dart';
import 'package:th.ac.ru.uSmart/providers/mr30_provider.dart';
import 'package:th.ac.ru.uSmart/providers/schedule_provider.dart';
import 'package:th.ac.ru.uSmart/schedule/schedule_home_screen.dart';
import 'package:th.ac.ru.uSmart/today/today_home_screen.dart';
import 'package:th.ac.ru.uSmart/utils/custom_functions.dart';

import 'model/mr30_model.dart';

class RuHomePage extends StatefulWidget {
  const RuHomePage({super.key});

  @override
  State<RuHomePage> createState() => _RuHomePageState();
}

class _RuHomePageState extends State<RuHomePage> with TickerProviderStateMixin {
  List<HomeList> homeList = HomeList.homeList;
  AnimationController? animationController;
  bool multiple = true;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    super.initState();

    // Future.microtask(
    //   () => context.read<MR30Provider>().add(
    //     RECORD(
    //         id: "25651ACC110140548126914561d22102022A",
    //         courseYear: "2567",
    //         courseSemester: "1",
    //         courseNo: "ACC1101",
    //         courseMethod : "4",
    //         courseMethodNumber : "0",
    //         dayCode : "5",
    //         timeCode : "4",
    //         roomGroup : "81269",
    //         instrGroup : "14561",
    //         courseCredit : "3",
    //         courseMethodDetail : "VDO.",
    //         dayNameS : "W",
    //         timePeriod : "1630-1820",
    //         courseRoom : " VKB401",
    //         courseInstructor : " DR.MATAWEE , DR.NARINTIP",
    //         showRu30 : "(AC101)PRINCIPLES OF ACCOUNTING 1",
    //         coursePr : "สำหรับนักศึกษา รหัส 59-64 คณะบริหารธุรกิจทุกสาขา\nลงทะเบียนเรียน",
    //         courseComment : "สำหรับนักศึกษา รหัส 65...เป็นต้นไปสาขาวิชาเอกบัญชี และสาขาวิชาเอกการบัญชีและการเงิน ลงทะเบียนเรียน",
    //         courseExamdate : "22 ต.ค. 2565 A"
    //     ),
    //   ),
    // );
    // Future.microtask(
    //   () => context.read<MR30Provider>().add(
    //     RECORD(
    //         id: "25651ACC110140548126914561d22102022A",
    //         courseYear: "2567",
    //         courseSemester: "1",
    //         courseNo: "ACC1102",
    //         courseMethod : "4",
    //         courseMethodNumber : "0",
    //         dayCode : "5",
    //         timeCode : "4",
    //         roomGroup : "81269",
    //         instrGroup : "14561",
    //         courseCredit : "3",
    //         courseMethodDetail : "VDO.",
    //         dayNameS : "W",
    //         timePeriod : "1630-1820",
    //         courseRoom : " VKB401",
    //         courseInstructor : " DR.MATAWEE , DR.NARINTIP",
    //         showRu30 : "(AC101)PRINCIPLES OF ACCOUNTING 1",
    //         coursePr : "สำหรับนักศึกษา รหัส 59-64 คณะบริหารธุรกิจทุกสาขา\nลงทะเบียนเรียน",
    //         courseComment : "สำหรับนักศึกษา รหัส 65...เป็นต้นไปสาขาวิชาเอกบัญชี และสาขาวิชาเอกการบัญชีและการเงิน ลงทะเบียนเรียน",
    //         courseExamdate : "22 ต.ค. 2565 A"
    //     ),
    //   ),
    // );

    //Provider.of<MR30Provider>(context, listen: false).getAllMR30();
    //Provider.of<MR30Provider>(context, listen: false).getAllMR30Year();
    Future.microtask(
      () => context.read<MR30Provider>().getAllMR30(),
    );
    // Future.microtask(
    //   () => context.read<MR30Provider>().getAllMR30Year(),
    // );
    Future.microtask(
      () => context.read<MR30Provider>().getHaveToday(),
    );
    Future.microtask(
      () => context.read<MR30Provider>().filterTimeCourseStudy(),
    );

    Future.microtask(
      () => context.read<ScheduleProvider>().fetchSchedules(),
    );
  }

  Future<bool> getData() async {
    //await Future<dynamic>.delayed(const Duration(milliseconds: 500));
    return true;
  }

  Future<List<RECORD>> getDataRecord() async {
    return context.watch<MR30Provider>().havetodayNow;
  }

  Future<List<Schedule>> getDataSchedule() async {
    return context.watch<ScheduleProvider>().schedules;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Consumer<MR30Provider>(
        builder: (context,mr30,child) {
          return FutureBuilder<bool>(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox();
              } else {
                final Animation<double> animationForImage =
                    Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: animationController!,
                    curve: Interval((1 / 7) * 2, 1.0, curve: Curves.fastOutSlowIn),
                  ),
                );
                late final AnimationController _controller = AnimationController(
                  duration: const Duration(seconds: 3),
                  vsync: this,
                )..repeat(reverse: true);
                late final Animation<double> _animation = CurvedAnimation(
                  parent: _controller,
                  curve: Curves.easeOutCubic,
                );
                return Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      appBar(),
                      imageSliderBar(animationForImage),
                      eventBar(),
                      havetodayNow(),
                      scheduleBar(),
                      homeBar(),
                    ],
                  ),
                );
              }
            },
          );
        }
      ),
    );
  }

  FadeTransition imageSliderBar(Animation<double> animationForImage) => FadeTransition(
    key: Key('imageSliderBar'),
    opacity: animationForImage, 
    child: homeImageSlider()
    );

  FutureBuilder scheduleBar(){
    return FutureBuilder<List<Schedule>>(
      key: Key('scheduleBar'),
            future: getDataSchedule(),
            builder: (BuildContext context, AsyncSnapshot<List<Schedule>> snapshot) {
              if (!snapshot.hasData) {
                return const Text('no data');
              } else {
                //print('data: ${snapshot.data!.length}');
                return ListView.builder(
                  padding: const EdgeInsets.all(1),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length > 0 ? 1 : 0,
                  itemBuilder: (context, index) {
                    return Card(
                      key: Key('schedule-${snapshot.data![index].id.toString()}'),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: ListTile(
                                  title: Text(
                                    '${formatDate(snapshot.data![index].startDate)} - ${formatDate(snapshot.data![index].endDate)}',
                                    style: TextStyle(
                                      fontFamily: AppTheme.ruFontKanit,
                                      color: AppTheme.ru_dark_blue,
                                      fontSize: 13,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${snapshot.data![index].eventName}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: AppTheme.ruFontKanit,
                                      color: AppTheme.ru_text_grey,
                                    ),
                                  ),
                                  trailing: BlinkText(
                                      '${commingTimeNewLine(DateTime.parse(snapshot.data![index].startDate), DateTime.now(), DateTime.parse(snapshot.data![index].endDate))}',
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontStyle: FontStyle.italic),
                                      beginColor: Colors.redAccent,
                                      endColor: Colors.red
                                          .shade50), //                             trailing: BlinkText(

                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ScheduleHomeScreen()),
                                    );
                                  },
                                  leading: Icon(
                                    Icons.timer,
                                    // color: Colors.lightBlue,
                                  ),
                                ),
                              ),
                            ),
                      ),
                    );
                  },
                );
              }
            },
          );
  }

  FutureBuilder havetodayNow(){
    return FutureBuilder<List<RECORD>>(
      key: Key('havetodayNow'),
            future: getDataRecord(),
            builder: (BuildContext context, AsyncSnapshot<List<RECORD>> snapshot) {
              if (!snapshot.hasData) {
                return const Text('no data');
              } else {
                //print('data: ${snapshot.data!.length}');
                return ListView.builder(
                  padding: const EdgeInsets.all(1),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length > 0 ? 1 : 0,
                  itemBuilder: (context, index) {
                    return Card(
                      key: Key(snapshot.data![index].courseNo!.toString()),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: ListTile(
                          title: Text(
                            '${snapshot.data![index].courseNo}',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          trailing: Text(
                              '${StringTimeStudy((snapshot.data![index].timePeriod).toString())}'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TodayHomeScreen()),
                            );
                          },
                          leading: Icon(Icons.bookmarks_rounded),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          );
  }

  ListView havetodayBar(MR30Provider mr30) {
    //print('havetodayNow : ${mr30.havetodayNow.length}');
    return ListView.builder(
      key: Key('havetodayBar'),
                  padding: const EdgeInsets.all(1),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: mr30.mr30.rECORD!.length > 0 ? 1 : 0,
                  itemBuilder: (context, index) {
                    return Card(
                      key: Key(mr30.mr30.rECORD![index].courseNo!.toString()),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: ListTile(
                          title: Text(
                            '${mr30.mr30.rECORD![index].courseNo}',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          trailing: Text(
                              '${StringTimeStudy((mr30.mr30.rECORD![index].timePeriod).toString())}'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TodayHomeScreen()),
                            );
                          },
                          leading: Icon(Icons.bookmarks_rounded),
                        ),
                      ),
                    );
                  },
                );
  }

  Padding eventBar() {
    return Padding(
      key: Key('eventBar'),
                  padding: const EdgeInsets.all(3),
                  child: Row(
                    children: [
                      Icon(Icons.list,
                          color: Color.fromARGB(255, 15, 0, 84), size: 18.0),
                      Text(
                        'กิจกรรมวันนี้',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: AppTheme.ruFontKanit,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                );
  }

  Expanded homeBar() {
    return Expanded(
      key: Key('homeBar'),
                  child: FutureBuilder<bool>(
                    future: getData(),
                    builder:
                        (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      if (!snapshot.hasData) {
                        return const SizedBox();
                      } else {
                        return GridView(
                          padding: const EdgeInsets.only(
                              top: 0, left: 12, right: 12),
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          children: List<Widget>.generate(
                            homeList.length,
                            (int index) {
                              final int count = homeList.length;
                              final Animation<double> animation =
                                  Tween<double>(begin: 0.0, end: 1.0).animate(
                                CurvedAnimation(
                                  parent: animationController!,
                                  curve: Interval((1 / count) * index, 1.0,
                                      curve: Curves.fastOutSlowIn),
                                ),
                              );
                              animationController?.forward();
                              return HomeListView(
                                animation: animation,
                                animationController: animationController,
                                listData: homeList[index],
                                callBack: () {
                                  Navigator.push<dynamic>(
                                    context,
                                    MaterialPageRoute<dynamic>(
                                      builder: (BuildContext context) =>
                                          homeList[index].navigateScreen!,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: multiple ? 4 : 3,
                            mainAxisSpacing: 6.0,
                            crossAxisSpacing: 6.0,
                            childAspectRatio: 1.0,
                          ),
                        );
                      }
                    },
                  ),
                );
  }

  Widget appBar() {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return SizedBox(
      key: Key('appBar'),
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'RU ConneXt',
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: AppTheme.ruFontKanit,
                    color: AppTheme.darkText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
              color: Colors.white,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius:
                      BorderRadius.circular(AppBar().preferredSize.height),
                  child: Icon(
                    multiple ? Icons.dashboard : Icons.view_agenda,
                    color: AppTheme.dark_grey,
                  ),
                  onTap: () {
                    setState(() {
                      multiple = !multiple;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeListView extends StatelessWidget {
  const HomeListView(
      {Key? key,
      this.listData,
      this.callBack,
      this.animationController,
      this.animation})
      : super(key: key);

  final HomeList? listData;
  final VoidCallback? callBack;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          key: Key('${listData!.imagePath}'),
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: AspectRatio(
              aspectRatio: 1.5,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    Positioned.fill(
                      child: Image.asset(
                        listData!.imagePath,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.grey.withOpacity(0.2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0)),
                        onTap: callBack,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}