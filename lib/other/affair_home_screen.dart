import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/fitness_app/fitness_app_theme.dart';
import 'package:th.ac.ru.uSmart/model/affair_list_data.dart';
import 'package:th.ac.ru.uSmart/other/affair_list_view.dart';
import 'package:th.ac.ru.uSmart/providers/rotcs_provider.dart';
import 'package:th.ac.ru.uSmart/ruconnext_app_theme.dart';

class AffairHomeScreen extends StatefulWidget {
  @override
  _AffairHomeScreenState createState() => _AffairHomeScreenState();
}

class _AffairHomeScreenState extends State<AffairHomeScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<AffairListData> affairList = AffairListData.affairList;

  // DateTime startDate = DateTime.now();
  // DateTime endDate = DateTime.now().add(const Duration(days: 5));

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    super.initState();
    getData();
    //Noti.initialize(flutterLocalNotificationsPlugin);
  }

  Future<bool> getData() async {
    print('call getData');
    await Provider.of<RotcsProvider>(context, listen: false).getAllRegister();
    await Provider.of<RotcsProvider>(context, listen: false).getAllExtend();
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
    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              //print('register : ${authen.profile.accessToken}');
              return Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      getAppBarUI(),
                      getListUI(),
                    ],
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget getListUI() {
    return Container(
      decoration: BoxDecoration(
        color: RuConnextAppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, -2),
              blurRadius: 8.0),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 80,
            child: FutureBuilder<bool>(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                } else {
                  return Stack(
                    children: <Widget>[
                      getBg(),
                      ListView.builder(
                        itemCount: affairList.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          final int count =
                              affairList.length > 10 ? 10 : affairList.length;
                          final Animation<double> animation =
                              Tween<double>(begin: 0.0, end: 1.0).animate(
                                  CurvedAnimation(
                                      parent: animationController!,
                                      curve: Interval((1 / count) * index, 1.0,
                                          curve: Curves.fastOutSlowIn)));
                          animationController?.forward();

                          return AffairListView(
                            callback: () {
                              Get.toNamed(affairList[index].navigateScreen);
                            },
                            affairData: affairList[index],
                            animation: animation,
                            animationController: animationController!,
                          );
                        },
                      )
                    ],
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget getBg() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: RuConnextAppTheme.buildLightTheme().backgroundColor,
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
              width: AppBar().preferredSize.height + 40,
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
              child: Center(
                child: Text(
                  'กองกิจการนักศึกษา',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 20,
              height: AppBar().preferredSize.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  // Material(
                  //   color: Colors.transparent,
                  //   child: InkWell(
                  //     borderRadius: const BorderRadius.all(
                  //       Radius.circular(32.0),
                  //     ),
                  //     onTap: () {},
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Icon(Icons.favorite_border),
                  //     ),
                  //   ),
                  // ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(FontAwesomeIcons.appStore),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
