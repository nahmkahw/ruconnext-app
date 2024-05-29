import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:th.ac.ru.uSmart/providers/register_provider.dart';
import 'package:th.ac.ru.uSmart/services/registerservice.dart';
import 'package:th.ac.ru.uSmart/store/register.dart';

class MockRegisterService extends Mock implements RegisterService {}

void main() {
  group('register', () {
    late RegisterProvider sut;
    late MockRegisterService mockRegisterService;

    setUp(() {
      mockRegisterService = MockRegisterService();
      sut = RegisterProvider(service: mockRegisterService);
    });

    test('initial value loading', () {
      // Stub a method before interacting with the mock.
      expect(sut.isLoading, false);
    });

    test('getRegisterAll', () async {
      // Stub a method before interacting with the mock.
      //Register register = Register();
      // when(() => mockRegisterService.getAllRegisterList('2565'))
      //     .thenAnswer((_) async => register);

      // verify(() => mockRegisterService.getAllRegisterList('2565')).called(1);
      sut.getAllRegister();
      expect(sut.isLoading, false);
    });
  });
}
