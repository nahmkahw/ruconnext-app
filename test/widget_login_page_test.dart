import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:th.ac.ru.uSmart/login_page.dart';
import 'package:th.ac.ru.uSmart/model/profile.dart';
import 'package:th.ac.ru.uSmart/providers/authenprovider.dart';
import 'package:th.ac.ru.uSmart/services/authenservice.dart'; // Replace with your actual import path

class MockAuthenService extends Mock implements AuthenService {
  var isLoading = false;
}

void main() {
  late MockAuthenService mockAuthenService;
  late AuthenProvider authenProvider;

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
    authenProvider = AuthenProvider(service: mockAuthenService);
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => AuthenProvider(
            service: mockAuthenService), // Provide your actual AuthenProvider
        child: LoginPage(),
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

  testWidgets('click googleAuthButtonTest will call google login test',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    // Find the TextField by its key.
    final textFieldFinder = find.byKey(Key('StudentCode'));
    // Enter blank text into the TextField.
    await tester.enterText(textFieldFinder, '6299999991');

    // Trigger a rebuild of the widget tree.
    await tester.pump();

    // Verify the state or appearance of the widget based on the entered text.
    expect(find.text('6299999991'), findsOneWidget);

    final googleAuthButtonTest = find.byKey(Key('googleAuthButtonTest'));

    expect(googleAuthButtonTest, findsOneWidget);

    // Simulate a tap on the button.
    await tester.tap(googleAuthButtonTest);
    await tester.pump(const Duration(seconds: 2));
    verify(() => authenProvider.logintest(BuildContext, "6299999991"))
        .called(1);
    await tester.pumpAndSettle();
  });

  testWidgets('click googleAuthButton will call google login',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    // Find the TextField by its key.
    final textFieldFinder = find.byKey(Key('StudentCode'));
    // Enter blank text into the TextField.
    await tester.enterText(textFieldFinder, '6299999992');

    // Trigger a rebuild of the widget tree.
    await tester.pump();

    // Verify the state or appearance of the widget based on the entered text.
    expect(find.text('6299999992'), findsOneWidget);

    final googleAuthButtonTest = find.byKey(Key('googleAuthButton'));

    expect(googleAuthButtonTest, findsOneWidget);

    // Simulate a tap on the button.
    await tester.tap(googleAuthButtonTest);
    await tester.pump(const Duration(seconds: 2));
    verify(() => authenProvider.login(BuildContext)).called(1);
    await tester.pumpAndSettle();
  });

  testWidgets('page login is displayed', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byKey(Key('StudentCode')), findsOneWidget);

    await tester.pump();

    expect(find.text('Enter Student Code 10-digit Number'), findsOneWidget);

    // Find the Image by its key or other identifier.
    final imageFinder = find.byWidgetPredicate(
      (widget) => widget is Image && widget.image is AssetImage,
    );

    // Verify that the Image.asset widget is present.
    expect(imageFinder, findsOneWidget);

    // You can also verify specific properties of the Image widget.
    final Image imageWidget = tester.widget(imageFinder) as Image;
    expect(imageWidget.height, 80);
    expect(imageWidget.image, isA<AssetImage>());
  });

  testWidgets('input StudentCode blank', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    // Find the TextField by its key.
    final textFieldFinder = find.byKey(Key('StudentCode'));
    // Enter blank text into the TextField.
    await tester.enterText(textFieldFinder, '');

    // Trigger a rebuild of the widget tree.
    await tester.pump();

    // Verify the state or appearance of the widget based on the entered text.
    expect(find.text(''), findsOneWidget);
  });

  testWidgets('input StudentCode not equal 10 character.',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    // Find the TextField by its key.
    final textFieldFinder = find.byKey(Key('StudentCode'));
    // Enter blank text into the TextField.
    await tester.enterText(textFieldFinder, '629999999');

    // Trigger a rebuild of the widget tree.
    await tester.pump();

    // Verify the state or appearance of the widget based on the entered text.
    expect(find.text('629999999'), findsOneWidget);

    expect(find.byKey(Key('googleAuthButton')), findsNothing);
    expect(find.byKey(Key('googleAuthButtonTest')), findsNothing);
  });

  testWidgets('input StudentCode : 6299999991 and Show googleAuthButtonTest',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    // Find the TextField by its key.
    final textFieldFinder = find.byKey(Key('StudentCode'));
    // Enter blank text into the TextField.
    await tester.enterText(textFieldFinder, '6299999991');

    // Trigger a rebuild of the widget tree.
    await tester.pump();

    // Verify the state or appearance of the widget based on the entered text.
    expect(find.text('6299999991'), findsOneWidget);

    expect(find.byKey(Key('googleAuthButtonTest')), findsOneWidget);
  });

  testWidgets('input StudentCode : 6299999992 and Show googleAuthButton',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    // Find the TextField by its key.
    final textFieldFinder = find.byKey(Key('StudentCode'));
    // Enter blank text into the TextField.
    await tester.enterText(textFieldFinder, '6299999992');

    // Trigger a rebuild of the widget tree.
    await tester.pump();

    // Verify the state or appearance of the widget based on the entered text.
    expect(find.text('6299999992'), findsOneWidget);

    expect(find.byKey(Key('googleAuthButton')), findsOneWidget);
  });

  testWidgets('login test StudentCode : 6299999991',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    // Find the TextField by its key.
    final textFieldFinder = find.byKey(Key('StudentCode'));
    // Enter blank text into the TextField.
    await tester.enterText(textFieldFinder, '6299999991');

    // Trigger a rebuild of the widget tree.
    await tester.pump();

    // Verify the state or appearance of the widget based on the entered text.
    expect(find.text('6299999991'), findsOneWidget);

    expect(find.byKey(Key('googleAuthButtonTest')), findsOneWidget);
  });
}
