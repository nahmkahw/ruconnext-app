import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/model/rotcs_register.dart';
import 'package:th.ac.ru.uSmart/providers/rotcs_provider.dart';
import 'package:th.ac.ru.uSmart/rotcs/rotcs_register_screen.dart';
import 'package:th.ac.ru.uSmart/services/rotcsservice.dart'; // Replace with your actual import path

class MockRotcsService extends Mock implements RotcsService {}

void main() {
  late MockRotcsService mockRotcsService;
  late RotcsProvider rotcsChangeNotifier;

  final studentRotcsRegisterFromService = RotcsRegister.fromJson({
    "studentCode": "6505003472",
    "total": 4,
    "detail": [
      {
        "yearReport": "2565",
        "locationArmy": "รร.เทพศิรินทร์ร่มเกล้า",
        "layerArmy": "2",
        "layerReport": "3",
        "typeReport": "เลื่อนชั้น",
        "status": "-"
      },
      {
        "yearReport": "2565",
        "locationArmy": "รร.เทพศิรินทร์ร่มเกล้า",
        "layerArmy": "2",
        "layerReport": "3",
        "typeReport": "โอนย้ายสถานศึกษาวิชาทหาร",
        "status": "-"
      },
      {
        "yearReport": "2565",
        "locationArmy": "รร.เทพศิรินทร์ร่มเกล้า",
        "layerArmy": "2",
        "layerReport": "3",
        "typeReport": "โอนย้ายสถานศึกษาวิชาทหาร",
        "status": "-"
      },
      {
        "yearReport": "2566",
        "locationArmy": "มหาวิทยาลัยรามคำแหง",
        "layerArmy": "3",
        "layerReport": "4",
        "typeReport": "เลื่อนชั้น",
        "status": "-"
      }
    ]
  });

  void arrangeStudentRotcsRegisterFromService() {
    when(() => mockRotcsService.getRegisterAll()).thenAnswer((_) async {
      // Simulate an asynchronous process
      //await Future.delayed(const Duration(microseconds: 500));
      return studentRotcsRegisterFromService; // Return your mocked data here
    });
  }

  void arrangeStudentRotcsRegisterFromServiceDelay2Seconds() {
    when(() => mockRotcsService.getRegisterAll()).thenAnswer((_) async {
      // Simulate an asynchronous process
      await Future.delayed(const Duration(seconds: 2));
      return studentRotcsRegisterFromService; // Return your mocked data here
    });
  }

  setUp(() {
    mockRotcsService = MockRotcsService();
    rotcsChangeNotifier = RotcsProvider(service: mockRotcsService);
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => RotcsProvider(
            service: mockRotcsService), // Provide your actual AuthenProvider
        child: RotcsRegisterScreen(),
      ),
    );
  }

  group("Rotcs Register Change Notifier test", () {
    test('getAllRegister will call service ', () async {
      arrangeStudentRotcsRegisterFromService();
      await rotcsChangeNotifier.getAllRegister();
      verify(() => mockRotcsService.getRegisterAll()).called(1);
    });

    test('indicater loading of data', () async {
      arrangeStudentRotcsRegisterFromService();
      final future = rotcsChangeNotifier.getAllRegister();
      expect(rotcsChangeNotifier.isLoading, true);
      await future;
      // expect(
      //     rotcsChangeNotifier.rotcsregister, studentRotcsRegisterFromService);
      expect(rotcsChangeNotifier.isLoading, false);
    });
  });

  group("Rotcs Register Page test", () {
    testWidgets(
      "title is displayed",
      (WidgetTester tester) async {
        arrangeStudentRotcsRegisterFromService();
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump(const Duration(seconds: 2));
        expect(find.byKey(Key('title-register')), findsOneWidget);
      },
    );

    testWidgets(
      "loading indicator is displayed while waiting for register",
      (WidgetTester tester) async {
        arrangeStudentRotcsRegisterFromServiceDelay2Seconds();
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump(const Duration(microseconds: 500));
        expect(find.byKey(Key('progress-indicator')), findsOneWidget);
        await tester.pumpAndSettle();
      },
    );

    testWidgets(
      "list register is displayed",
      (WidgetTester tester) async {
        arrangeStudentRotcsRegisterFromServiceDelay2Seconds();
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pump(const Duration(seconds: 3));
        expect(find.byKey(Key('list-register')), findsOneWidget);
        await tester.pumpAndSettle();
      },
    );
  });
}
