import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_store/presentation/bloc/login/login_bloc.dart';
import 'package:mobile_store/presentation/bloc/register/register_bloc.dart';
import 'package:mobile_store/presentation/pages/login_page.dart';
void main() {
  group(
    "Test create login page",
        () {
      testWidgets(
        "Verify create login page",
            (WidgetTester tester) async {
          await tester.pumpWidget(MaterialApp(
            home: LoginPage(),
          ));

          /// Find Scaffold
          var findScaffold = find.byType(Scaffold);
          expect(findScaffold, findsOneWidget);

          /// find blocConsumer
          var findBlocConsumer = find.byType(BlocConsumer<LoginBloc, LoginState>);
          expect(findBlocConsumer, findsOneWidget);

          /// find column
          var findColumn = find.byKey(Key('login_column'));
          expect(findColumn, findsOneWidget);

          /// find nameField
          var findNameField = find.byKey(Key('login_name_field'));
          expect(findNameField, findsOneWidget);

          /// find passwordField
          var findPasswordField = find.byKey(Key('login_password_field'));
          expect(findPasswordField, findsOneWidget);

          /// find elevatedButton
          var findElevatedButton = find.byType(ElevatedButton);
          expect(findElevatedButton, findsOneWidget);

          /// find TextButton
          var findTextButton = find.byType(TextButton);
          expect(findTextButton, findsOneWidget);

          },
      );
    },
  );
  group('Email Validation', () {
    test('Valid Email', () {
      final email = 'test@example.com';
      expect(validateEmailAddress(email), true);
    });
    test('Invalid Email - Missing @', () {
      final email = 'testexample.com';
      expect(validateEmailAddress(email), false);
    });
    test('Invalid Email - Missing domain', () {
      final email = 'test@';
      expect(validateEmailAddress(email), false);
    });
    test('Invalid Email - Missing top-level domain', () {
      final email = 'test@example';
      expect(validateEmailAddress(email), false);
    });
    test('Invalid Email - Missing username', () {
      final email = '@example.com';
      expect(validateEmailAddress(email), false);
    });



  });

  group('Check Text field data', () {
    test('check email is empty or not ', () {
      final email = '';
      expect(checkTextField(value: email),true);
    });

    test('check password is empty or not ', () {
      final password = '1234';
      expect(checkTextField(value: password), false);
    });

  });
}