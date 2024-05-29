import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:th.ac.ru.uSmart/model/register_model.dart';
import 'package:th.ac.ru.uSmart/model/registeryear_model.dart';
import 'package:th.ac.ru.uSmart/providers/register_provider.dart';
import 'package:th.ac.ru.uSmart/services/registerservice.dart';
import 'package:th.ac.ru.uSmart/store/registeryear.dart';

class MockRegisterYearStorage extends Mock implements RegisterYearStorage {}

class MockRegisterService extends Mock implements RegisterService {}

void main() {
  group('RegisterProvider', () {
    late RegisterProvider registerProvider;
    late MockRegisterService mockRegisterService;

    setUp(() {
      mockRegisterService = MockRegisterService();
      registerProvider = RegisterProvider(service: mockRegisterService);
    });

    test('Test getAllRegister', () async {
      // Mock the behavior of RegisterYearStorage
      final mockRegisteryear =
          REGISTERYEAR(); // Provide a sample REGISTERYEAR instance
      when(() => RegisterYearStorage.getRegisterYear())
          .thenAnswer((_) async => mockRegisteryear);

      // Mock the behavior of RegisterService
      final Register mockResponse =
          Register(); // Provide a sample Register instance
      when(() => mockRegisterService.getAllRegisterList('2565'))
          .thenAnswer((_) async => mockResponse);

      // Call the method you want to test
      registerProvider.getAllRegister();

      // Verify the behavior and assertions
      expect(registerProvider.isLoading, false);
      expect(registerProvider.error, '');
      // Add more assertions to verify other behavior if needed
    });
  });
}
