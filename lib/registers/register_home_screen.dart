import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/fitness_app/models/tabIcon_data.dart';
import 'package:th.ac.ru.uSmart/registers/register_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login_page.dart';
import '../fitness_app/fitness_app_theme.dart';
import '../mr30/mr30_list_screen.dart';
import '../providers/authenprovider.dart';
import '../providers/register_provider.dart';

String? tokenRegis;

class RegisterHomeScreen extends StatefulWidget {
  @override
  _RegisterHomeScreenState createState() => _RegisterHomeScreenState();
}

class _RegisterHomeScreenState extends State<RegisterHomeScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: FitnessAppTheme.background,
  );

  @override
  void initState() {
      Provider.of<AuthenProvider>(context, listen: false).getProfile();
    Provider.of<RegisterProvider>(context, listen: false).getAllRegister();
    Provider.of<RegisterProvider>(context, listen: false).getAllRegisterYear();

    Provider.of<RegisterProvider>(context, listen: false).getRegisterAll();
    Provider.of<RegisterProvider>(context, listen: false).getAllMr30Catalog();
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = RegisterListScreen(animationController: animationController);
    super.initState();
    getData();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 600));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var authen = context.watch<AuthenProvider>();
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
              print('register : ${authen.profile.accessToken}');
              return authen.profile.accessToken != null
                  ? Stack(
                      children: <Widget>[
                        tabBody,
                      ],
                    )
                  : LoginPage();
            }
          },
        ),
      ),
    );
  }
}
