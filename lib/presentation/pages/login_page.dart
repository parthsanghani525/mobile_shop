import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile_store/presentation/pages/product_list_page.dart';
import 'package:mobile_store/presentation/pages/register_page.dart';

import '../../domain/repositories/user_repository_impl.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../resource/strings_manager.dart';
import '../bloc/login/login_bloc.dart';
import '../common_component/common_editext_view.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      /// Provide the LoginBloc to the widget tree
      create: (context) => LoginBloc(LoginUseCase(UserRepositoryImpl())),
      child: Scaffold(
        appBar: AppBar(title: const Text('Login')),

        /// AppBar with title
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              /// Listener for state changes in the LoginBloc
              if (state is LoginSuccess) {
                /// Navigate to ProductListPage on successful login
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductListPage(),
                    ));
              }
              if (state is LoginError) {
                if (context.read<LoginBloc>().snackBar != null) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(context.read<LoginBloc>().snackBar!);
                }
              }
            },
            builder: (context, state) {
              /// Builder method to build UI based on LoginBloc state
              return Column(
                key: Key('login_column'),
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// Widget for name field
                  _nameField(
                      loginBloc: context.read<LoginBloc>(),
                      key: Key('login_name_field')),
                  const SizedBox(height: 16),

                  /// Widget for password field
                  _passwordField(
                      loginBloc: context.read<LoginBloc>(),
                      key: Key('login_password_field')),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    /// Login button
                    onPressed: () =>
                        context.read<LoginBloc>().add(LoginButtonPressEvent()),
                    child: State is LoginLoading
                        ? const CircularProgressIndicator()

                        /// Show loading indicator when logging in
                        : const Text('Login'),
                  ),
                  const SizedBox(height: 16),

                  /// Button to navigate to RegisterPage
                  TextButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterPage(),
                        )),
                    child: const Text('Create an account'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  /// Widget for name text field
  Widget _nameField({required LoginBloc loginBloc, required Key key}) {
    return TextInputField(
        key: key,
        isPasswordField: false,
        errorText: loginBloc.errorName,

        /// Error text from LoginBloc state
        hintText: StringManager.name,
        textInputType: TextInputType.text,
        onChanged: (val) {
          if (val != null) {
            loginBloc.setUsername(val);

            /// Set username in LoginBloc
          }
        });
  }

  /// Widget for password text field
  Widget _passwordField({required LoginBloc loginBloc, required Key key}) {
    return TextInputField(
      key: key,
      errorText: loginBloc.errorPassword,

      /// Error text from LoginBloc state
      hintText: StringManager.password,
      textInputType: TextInputType.text,
      isPasswordField: true,
      onChanged: (val) {
        if (val != null) {
          loginBloc.setPassword(val);

          /// Set password in LoginBloc
        }
      },
    );
  }
}
