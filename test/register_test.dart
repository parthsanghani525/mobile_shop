import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_store/presentation/pages/register_page.dart';

void main() {
  group(
    "Test create register page",
    () {
      testWidgets(
        "Verify create register page",
        (WidgetTester tester) async {
          await tester.pumpWidget(MaterialApp(
            home: RegisterPage(),
          ));

          /// Find BlocProvider
          var findBlocProvider = find.byKey(Key('register_bloc_provider'));
          expect(findBlocProvider, findsOneWidget);

          /// Find Appbar
          var findAppbar = find.byKey(Key('register_appbar'));
          expect(findAppbar, findsOneWidget);

          /// Find Scaffold
          var findScaffold = find.byKey(Key('register_scaffold'));
          expect(findScaffold, findsOneWidget);

          /// Find Padding
          var findPadding = find.byKey(Key('register_padding'));
          expect(findPadding, findsOneWidget);

          /// Find BlocConsumer
          var findBlocConsumer = find.byKey(Key('register_bloc_consumer'));
          expect(findBlocConsumer, findsOneWidget);

          /// Find Column
          var findColumn = find.byKey(Key('register_column'));
          expect(findColumn, findsOneWidget);

          /// Find nameField
          var findNameField = find.byKey(Key('register_name_input_field'));
          expect(findNameField, findsOneWidget);

          /// Find EmailField
          var findEmailField = find.byKey(Key('register_email_input_field'));
          expect(findEmailField, findsOneWidget);

          /// Find PasswordField
          var findPasswordField =
              find.byKey(Key('register_password_input_field'));
          expect(findPasswordField, findsOneWidget);

          /// Find ConfirmPasswordField
          var findConfirmPasswordField =
              find.byKey(Key('register_confirm_password_input_field'));
          expect(findConfirmPasswordField, findsOneWidget);

          /// Find ElevatedButton
          var findElevatedButton = find.byKey(Key('register_elevated_button'));
          expect(findElevatedButton, findsOneWidget);
        },
      );
    },
  );
}
