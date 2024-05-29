import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:th.ac.ru.uSmart/pages/home_image_slider.dart';
import 'package:th.ac.ru.uSmart/providers/authenprovider.dart';
import 'package:th.ac.ru.uSmart/providers/grade_provider.dart';
import 'package:th.ac.ru.uSmart/providers/mr30_provider.dart';
import 'package:th.ac.ru.uSmart/providers/register_provider.dart';
import 'package:th.ac.ru.uSmart/today/today_home_screen.dart';
import 'package:th.ac.ru.uSmart/utils/custom_functions.dart';
import 'package:blinking_text/blinking_text.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/widget/ScheduleHome.dart';
import 'model/homelist.dart';
import 'providers/schedule_provider.dart';
import 'schedule/schedule_home_screen.dart';

class RamHomePage extends StatefulWidget {
  const RamHomePage({Key? key}) : super(key: key);

  @override
  _RamHomePageState createState() => _RamHomePageState();
}

String? token;
String? role;

class _RamHomePageState extends State<RamHomePage>
    with TickerProviderStateMixin {
  List<HomeList> homeList = HomeList.homeList;
  AnimationController? animationController;
  bool multiple = true;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    super.initState();
    //load grade
    //print('load grade');
    //Provider.of<GradeProvider>(context, listen: false).getAllGrade();

    //load register
    //print('load register');
    //Provider.of<RegisterProvider>(context, listen: false).getAllRegisterYear();
    //Provider.of<RegisterProvider>(context, listen: false).getAllRegister();

    //load today
    //print('load today');
    // Provider.of<MR30Provider>(context, listen: false).getYearSemesterLatest();
    // Provider.of<MR30Provider>(context, listen: false).getSchedule();
    // Provider.of<MR30Provider>(context, listen: false).getHaveToday();
    // Provider.of<MR30Provider>(context, listen: false).filterTimeCourseStudy();

    //load schedule
    //print('load schedule');

    //load mr30
    //print('load mr30');
    // Provider.of<MR30Provider>(context, listen: false).getAllMR30Year();
    // Provider.of<MR30Provider>(context, listen: false).getAllMR30();
  }

  Future<bool> getData() async {
    //await Future<dynamic>.delayed(const Duration(milliseconds: 600));
    return true;
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
    // var mr30 = context.read<MR30Provider>();
    // mr30.getHaveToday();

    // var authen = context.watch<AuthenProvider>();
    // authen.getProfile();
    // print('Role: ${authen.role}');
    // switch (authen.role) {
    //   case "Doctor":
    //     homeList = HomeList.homeListDoctor;
    //     break;
    //   case "Master":
    //     homeList = HomeList.homeListMaster;
    //     break;
    //   case "Bachelor":
    //     homeList = HomeList.homeListBachelor;
    //     break;
    //   default:
    //     homeList = HomeList.homeList;
    //     break;
    // }

    // var scheduleProv = context.read<ScheduleProvider>();
    // scheduleProv.fetchSchedules();

    return Scaffold(
      backgroundColor:
          isLightMode == true ? AppTheme.white : AppTheme.nearlyBlack,
      body: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox(
              key: Key('Error'),
            );
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
                  //imageSlide(animationForImage),
                  TitleWidget(isLightMode: isLightMode),
                  ScheduleHome(),
                  // listHaveToDay(mr30),
                  // listSchedules(scheduleProv),
                  // listHome(homeList),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Expanded listHome(List<HomeList> homeList) {
    //context.read<GradeProvider>().getAllGrade();
    return Expanded(
      key: Key('listHome'),
      child: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return GridView(
              padding: const EdgeInsets.only(top: 0, left: 12, right: 12),
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
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: multiple ? 3 : 2,
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

  ListView listSchedules(ScheduleProvider scheduleProv) {
    return ListView.builder(
      key: Key('listSchedules'),
      padding: const EdgeInsets.all(1),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: scheduleProv.schedules.length > 0 ? 1 : 0,
      itemBuilder: (context, index) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: ListTile(
              title: Text(
                '${formatDate(scheduleProv.schedules[0].startDate)} - ${formatDate(scheduleProv.schedules[0].endDate)}',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              subtitle: Text(
                '${scheduleProv.schedules[0].eventName}',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              // trailing: Text(
              //   ' ${commingTime(DateTime.parse(scheduleProv.schedules[0].startDate), DateTime.now(), DateTime.parse(scheduleProv.schedules[0].endDate))}',
              //   style: TextStyle(
              //       color: Colors.redAccent,
              //       fontSize: 12,
              //       fontStyle: FontStyle.italic),
              // ),
              trailing: BlinkText(
                  '${commingTimeNewLine(DateTime.parse(scheduleProv.schedules[0].startDate), DateTime.now(), DateTime.parse(scheduleProv.schedules[0].endDate))}',
                  style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                  beginColor: Colors.redAccent,
                  endColor: Colors.red
                      .shade50), //                             trailing: BlinkText(

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScheduleHomeScreen()),
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
  }

  ListView listHaveToDay(MR30Provider mr30) {
    return ListView.builder(
      key: Key('listHaveToDay'),
      padding: const EdgeInsets.all(1),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: mr30.havetodayNow.length > 0 ? 1 : 0,
      itemBuilder: (context, index) {
        return mr30.isLoading
            ? Text(key: Key('loadingHaveToDay'), '  loadingHaveToDay')
            : Card(
                key: Key('dataHaveToDay'),
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: ListTile(
                    title: Text(
                      '${mr30.havetodayNow[index].courseNo}',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    trailing: Text(
                        '${StringTimeStudy(mr30.havetodayNow[index].timePeriod.toString())}'),
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

  FadeTransition imageSlide(Animation<double> animationForImage) {
    return FadeTransition(
        key: Key('imageSlide'),
        opacity: animationForImage,
        child: homeImageSlider());
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
                    color: isLightMode ? AppTheme.darkText : AppTheme.white,
                    fontWeight: FontWeight.w700,
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
              color: isLightMode ? Colors.white : AppTheme.nearlyBlack,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius:
                      BorderRadius.circular(AppBar().preferredSize.height),
                  child: Icon(
                    multiple ? Icons.dashboard : Icons.view_agenda,
                    color: isLightMode ? AppTheme.dark_grey : AppTheme.white,
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

class TitleWidget extends StatelessWidget {
  TitleWidget({super.key, required this.isLightMode});

  final bool isLightMode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: Key('titleEvent'),
      padding: const EdgeInsets.all(3),
      child: Row(
        children: [
          Icon(Icons.list,
              color:
                  isLightMode == false ? AppTheme.white : AppTheme.nearlyBlack),
          Text(
            'กิจกรรมวันนี้...',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                color: isLightMode == false
                    ? AppTheme.white
                    : AppTheme.nearlyBlack),
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
    var mr30 = context.watch<MR30Provider>();
    return AnimatedBuilder(
      key: Key('HomeListView'),
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: AspectRatio(
              aspectRatio: 1.5,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                child: InkWell(
                  splashColor: Colors.grey.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  onTap: callBack,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(0, 0, 0, 0),
                        borderRadius: BorderRadius.circular(26),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('${listData!.imagePath}'))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: '' != 'วันนี้เรียนอะไร'
                                  ? SizedBox()
                                  : Container(
                                      padding: EdgeInsets.all(10),
                                      height: 32,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: Colors.orangeAccent,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Text('${mr30.havetoday.length}',
                                          style: AppTheme.caption)),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text('${''}', style: AppTheme.caption),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // child: Stack(
                //   alignment: AlignmentDirectional.center,
                //   children: <Widget>[
                //     Positioned.fill(
                //       child: Image.asset(
                //         listData!.imagePath,
                //         fit: BoxFit.contain,
                //       ),
                //     ),
                //     Material(
                //       color: Colors.transparent,
                //       child: InkWell(
                //         splashColor: Colors.grey.withOpacity(0.2),
                //         borderRadius:
                //             const BorderRadius.all(Radius.circular(4.0)),
                //         onTap: callBack,
                //       ),
                //     ),
                //   ],
                // ),
              ),
            ),
          ),
        );
      },
    );
  }
}
