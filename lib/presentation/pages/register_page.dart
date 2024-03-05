import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/user_repository_impl.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../resource/strings_manager.dart';
import '../bloc/register/register_bloc.dart';
import '../common_component/common_editext_view.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      /// Provide RegisterBloc to the widget tree
      key: Key('register_bloc_provider'),
      create: (BuildContext context) =>
          RegisterBloc(registerUseCase: RegisterUseCase(UserRepositoryImpl())),
      child: Scaffold(
        key: Key('register_scaffold'),
        appBar: AppBar(
          key: Key('register_appbar'),
          title: const Text('Register'),
        ),
        body: Padding(
          key: Key('register_padding'),
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<RegisterBloc, RegisterState>(
            /// Listen for changes in RegisterBloc state
            key: Key('register_bloc_consumer'),
            listener: (context, state) {
              /// Execute code when registration is successful
              if (state is Success) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(context.read<RegisterBloc>().snackBar!);
                Navigator.pop(context);

                /// Return to previous page
              }
              if (state is Error) {
                if (context.read<RegisterBloc>().snackBar != null) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(context.read<RegisterBloc>().snackBar!);
                }
              }
            },
            builder: (context, state) {
              return Column(
                key: Key('register_column'),
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),

                  /// Name text field
                  _nameField(context),
                  const SizedBox(height: 10),

                  /// Email text field
                  _emailField(context),
                  const SizedBox(height: 10),

                  /// Password text field
                  _passwordField(context),
                  const SizedBox(height: 10),

                  /// Confirm password text field
                  _confirmPasswordField(context),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    key: Key('register_elevated_button'),
                    onPressed: () =>
                        context.read<RegisterBloc>().add(Register()),

                    /// Show loading indicator when registering
                    child: state is Loading
                        ? const CircularProgressIndicator()
                        : const Text('Register'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  /// Widget for confirm password text field
  Widget _confirmPasswordField(BuildContext context) {
    return TextInputField(
      key: Key('register_confirm_password_input_field'),
      errorText: context.watch<RegisterBloc>().errorConfirmPassword,
      hintText: StringManager.confirmPsw,
      textInputType: TextInputType.text,
      isPasswordField: true,
      onChanged: (val) {
        if (val!.isNotEmpty) {
          context.read<RegisterBloc>().setConfirmPassword(val);
        }
      },
    );
  }

  /// Widget for password text field
  Widget _passwordField(BuildContext context) {
    return TextInputField(
      key: Key('register_password_input_field'),
      errorText: context.watch<RegisterBloc>().errorPassword,
      hintText: StringManager.password,
      isPasswordField: true,
      textInputType: TextInputType.text,
      onChanged: (val) {
        if (val!.isNotEmpty) {
          context.read<RegisterBloc>().setPassword(val);
        }
      },
    );
  }

  /// Widget for email text field
  Widget _emailField(BuildContext context) {
    return TextInputField(
      key: Key('register_email_input_field'),
      isPasswordField: false,
      errorText: context.watch<RegisterBloc>().errorEmail,
      hintText: StringManager.emailAddress,
      textInputType: TextInputType.emailAddress,
      onChanged: (val) {
        if (val!.isNotEmpty) {
          context.read<RegisterBloc>().setEmail(val);
        }
      },
    );
  }

  /// Widget for name text field
  Widget _nameField(BuildContext context) {
    return TextInputField(
      key: Key('register_name_input_field'),
      isPasswordField: false,
      errorText: context.watch<RegisterBloc>().errorUsername,
      hintText: StringManager.name,
      textInputType: TextInputType.text,
      onChanged: (val) {
        if (val!.isNotEmpty) {
          context.read<RegisterBloc>().setUsername(val);
        }
      },
    );
  }
}
