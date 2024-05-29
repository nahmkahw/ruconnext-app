import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:test/test.dart';
import 'package:th.ac.ru.uSmart/main.dart';
import 'package:th.ac.ru.uSmart/model/register_model.dart';
import 'package:th.ac.ru.uSmart/providers/register_provider.dart';
import 'package:th.ac.ru.uSmart/services/registerservice.dart';
import 'package:th.ac.ru.uSmart/store/registeryear.dart';

// Create a mock class for RegisterYearStorage
class MockRegisterYearStorage extends Mock implements RegisterYearStorage {}

// Create a mock class for your service
class MockService extends Mock implements RegisterService {}

void main() {
  group('RegisterProvider', () {
    late RegisterProvider registerProvider;
    late MockRegisterYearStorage mockRegisterYearStorage;
    late MockService mockService;

    setUp(() {
      mockService = MockService();
      registerProvider = RegisterProvider(service: mockService);
      mockRegisterYearStorage = MockRegisterYearStorage();
    });

    test('Test getAllRegister any', () async {
      // Create a mock instance of REGISTERYEAR

      // Mocking RegisterYearStorage behavior

      // Create a mock instance of response
      final mockResponse = yourResponseType();
      // Mocking Service behavior
      when(() => mockService.getAllRegisterList(any()))
          .thenAnswer((_) async => mockResponse);

      // Provide the mock instances using Provider.value
      runApp(
        MultiProvider(
          providers: [
            Provider.value(value: RegisterProvider),
            Provider<RegisterYearStorage>.value(value: mockRegisterYearStorage),
            Provider<RegisterService>.value(value: mockService),
          ],
          child: MyApp(),
        ),
      );

      registerProvider.getAllRegister();

      expect(registerProvider.isLoading, false);
      expect(registerProvider.registeryear.recordyear, null);
    });

    test('Loading state', () async {
      when(() => mockService.getAllRegisterList('2565')).thenAnswer((_) async =>
          Future.value(Register())); // Return your mocked data here

      when(() => mockService.getAllRegisterList('2565')).thenAnswer((_) async {
        registerProvider.isLoading = true;
        registerProvider.notifyListeners();

        // Simulate an asynchronous process
        await Future.delayed(Duration(seconds: 2));

        registerProvider.isLoading = false;
        registerProvider.notifyListeners();

        return Future.value(Register()); // Return your mocked data here
      });

      expect(registerProvider.isLoading, false);

      registerProvider.getAllRegister();

      expect(registerProvider.isLoading, true);

      await Future.delayed(
          Duration(seconds: 3)); // Wait for the loading process to finish

      expect(registerProvider.isLoading, false);

      verify(() => mockService.getAllRegisterList('2565')).called(1);
    });

    test('test call getAllRegisterList & check loading', () async {
      when(() => mockService.getAllRegisterList('2565')).thenAnswer((_) async {
        registerProvider.isLoading = true;
        registerProvider.notifyListeners();

        // Simulate an asynchronous process
        await Future.delayed(Duration(seconds: 2));

        registerProvider.isLoading = false;
        registerProvider.notifyListeners();

        return Future.value(Register()); // Return your mocked data here
      });

      expect(registerProvider.isLoading, false);

      registerProvider.getAllRegisterByYear('2565');

      expect(registerProvider.isLoading, true);

      await Future.delayed(
          Duration(seconds: 3)); // Wait for the loading process to finish

      expect(registerProvider.isLoading, false);

      verify(() => mockService.getAllRegisterList('2565')).called(1);
    });
  });
}

yourResponseType() {}

Future<Register> yourResponseType2564() async {
  Register registerlist = Register.fromJson({
    "std_code": "6299999991",
    "year": "2564",
    "RECORD": [
      {"year": "2564", "semester": "5", "course_no": "ECO3520", "credit": "3"},
      {"year": "2564", "semester": "5", "course_no": "ECO2123", "credit": "3"},
      {"year": "2564", "semester": "5", "course_no": "MTH1103", "credit": "3"},
      {"year": "2564", "semester": "3", "course_no": "ECO3520", "credit": "3"},
      {"year": "2564", "semester": "3", "course_no": "ECO3220", "credit": "3"},
      {"year": "2564", "semester": "3", "course_no": "MTH1103", "credit": "3"},
      {"year": "2564", "semester": "2", "course_no": "ENG1002", "credit": "3"},
      {"year": "2564", "semester": "2", "course_no": "ENG1001", "credit": "3"},
      {"year": "2564", "semester": "2", "course_no": "ECO3420", "credit": "3"},
      {"year": "2564", "semester": "2", "course_no": "ECO2123", "credit": "3"},
      {"year": "2564", "semester": "2", "course_no": "ECO2122", "credit": "3"},
      {"year": "2564", "semester": "2", "course_no": "ECO2124", "credit": "3"}
    ]
  });
  return registerlist;
}
