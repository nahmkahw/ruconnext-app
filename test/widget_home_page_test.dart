import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/home_screen.dart';
import 'package:th.ac.ru.uSmart/home_screen_tmp.dart';
import 'package:th.ac.ru.uSmart/model/profile.dart';
import 'package:th.ac.ru.uSmart/providers/authenprovider.dart';
import 'package:th.ac.ru.uSmart/providers/mr30_provider.dart';
import 'package:th.ac.ru.uSmart/providers/register_provider.dart';
import 'package:th.ac.ru.uSmart/providers/schedule_provider.dart';
import 'package:th.ac.ru.uSmart/services/authenservice.dart';
import 'package:th.ac.ru.uSmart/services/mr30service.dart';
import 'package:th.ac.ru.uSmart/services/registerservice.dart';
import 'package:th.ac.ru.uSmart/services/schedule_service.dart'; // Replace with your actual import path

class MockAuthenService extends Mock implements AuthenService {}

class MockRegisterService extends Mock implements RegisterService {}

class MockMR30Service extends Mock implements MR30Service {}

class MockScheduleService extends Mock implements ScheduleService {}

void main() {
  late MockAuthenService mockAuthenService;
  late MockRegisterService mockRegisterService;
  late MockMR30Service mockMR30Service;
  late MockScheduleService mockScheduleService;

  late AuthenProvider authenProvider;
  late MR30Provider mr30Provider;
  late RegisterProvider registerProvider;
  late ScheduleProvider scheduleProvider;

  final studentProfile6299999991FromService = Future.value(Profile.fromJson({
    'displayName': "6299999991",
    'email': "6299999991@rumail.ru.ac.th",
    'studentCode': "6299999991",
    'photoUrl': 'photoUrl',
    'googleToken': 'googleToken',
    "accessToken": "accessToken",
    "refreshToken": "refreshToken",
    "isAuth": true,
  }));

  final studentProfile6299999992FromService = Future.value(Profile.fromJson({
    'displayName': "6299999992",
    'email': "6299999992@rumail.ru.ac.th",
    'studentCode': "6299999992",
    'photoUrl': 'photoUrl',
    'googleToken': 'googleToken',
    "accessToken": "accessToken",
    "refreshToken": "refreshToken",
    "isAuth": true,
  }));

  void arrangeStudentProfile6299999991FromService() {
    when(() => mockAuthenService.getAuthenGoogleTest('6299999991'))
        .thenAnswer((_) async {
      // Simulate an asynchronous process
      await Future.delayed(const Duration(seconds: 2));
      return studentProfile6299999991FromService; // Return your mocked data here
    });
  }

  void arrangeStudentProfile6299999992FromService() {
    when(() => mockAuthenService.getAuthenGoogle()).thenAnswer((_) async {
      // Simulate an asynchronous process
      await Future.delayed(const Duration(seconds: 2));
      return studentProfile6299999992FromService; // Return your mocked data here
    });
  }

  setUp(() {
    mockAuthenService = MockAuthenService();
    mockMR30Service = MockMR30Service();
    mockScheduleService = MockScheduleService();
    mockRegisterService = MockRegisterService();

    authenProvider = AuthenProvider(service: AuthenService());
    mr30Provider = MR30Provider(service: mockMR30Service);
    scheduleProvider = ScheduleProvider(service: mockScheduleService);
    registerProvider = RegisterProvider(service: mockRegisterService);
  });

  Widget createWidgetUnderTest() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenProvider>(
            create: (_) => AuthenProvider(service: AuthenService())),
        ChangeNotifierProvider<MR30Provider>(
            create: (_) => MR30Provider(service: mockMR30Service)),
        ChangeNotifierProvider<RegisterProvider>(
            create: (_) => RegisterProvider(service: mockRegisterService)),
        ChangeNotifierProvider<ScheduleProvider>(
            create: (_) => ScheduleProvider(service: mockScheduleService)),
      ],
      child: MaterialApp(
        home: MyHomePage(),
      ),
    );
  }

  test('call logintest will call service google authen test', () async {
    arrangeStudentProfile6299999991FromService();
    authenProvider.logintest(BuildContext, "6299999991");
    verify(() => mockAuthenService.getAuthenGoogleTest("6299999991")).called(1);
  });

  test('call login will call service google authen', () async {
    arrangeStudentProfile6299999992FromService();
    authenProvider.login(BuildContext);
    verify(() => mockAuthenService.getAuthenGoogle()).called(1);
  });

  testWidgets('home page is displayed', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();
    // Find the TextField by its key.
    final appBar = find.byKey(Key('appBar'));
    // final imageSlide = find.byKey(Key('imageSlide'));
    //final titleEvent = find.byKey(Key('titleEvent'));
    //final listHaveToDay = find.byKey(Key('listHaveToDay'));
    final listSchedules = find.byKey(Key('listSchedules'));
    //final listHome = find.byKey(Key('listHome'));
    expect(appBar, findsOneWidget);
    //expect(imageSlide, findsOneWidget);
    //expect(titleEvent, findsOneWidget);
    //expect(listHaveToDay, findsOneWidget);
    expect(listSchedules, findsOneWidget);
    //expect(listHome, findsOneWidget);

    await tester.pumpAndSettle();
  });
}
