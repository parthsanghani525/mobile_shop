import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../data/models/user.dart';
import '../../../domain/usecases/register_usecase.dart';
import '../../../resource/strings_manager.dart';

part 'register_event.dart';
part 'register_state.dart';

/// Bloc responsible for managing the registration process.
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;

  bool isLoading = false;
  String username = '';
  String password = '';
  String email = '';
  String confirmPassword = '';

  /// Error messages for validation.
  String errorEmail = '';
  String errorPassword = '';
  String errorUsername = '';
  String errorConfirmPassword = '';

  /// Setter methods for updating the username, password, email, confirm password and error messages.
  void setUsername(String value) => username = value;
  void setPassword(String value) => password = value;
  void setEmail(String value) => email = value;
  void setConfirmPassword(String value) => confirmPassword = value;

  void setErrorUsername(String value) => errorUsername = value;
  void setErrorPassword(String value) => errorPassword = value;
  void setErrorEmail(String value) => errorEmail = value;
  void setErrorConfirmPassword(String value) => errorConfirmPassword = value;

  /// Snackbar for displaying feedback messages.
  SnackBar? snackBar;

  /// Constructor for RegisterBloc.
  RegisterBloc({required this.registerUseCase}) : super(RegisterInitial()) {
    on<Register>(_register);
  }

  /// Method to handle the registration process.
  void _register(Register event, Emitter<RegisterState> emit) async {
    try {
      if (username.isEmpty) {
        setErrorUsername(StringManager.enterName);
        emit(Error());
      } else if (email.isEmpty) {
        setErrorUsername('');
        setErrorEmail(StringManager.enterEmail);
        emit(Error());
      } else if (!validateEmailAddress(email)) {
        setErrorUsername('');
        setErrorEmail(StringManager.enterValidEmailAddress);
        emit(Error());
      } else if (password.isEmpty) {
        setErrorUsername('');
        setErrorEmail('');
        setErrorPassword(StringManager.enterPassword);
        emit(Error());
      } else if (confirmPassword.isEmpty) {
        setErrorUsername('');
        setErrorEmail('');
        setErrorPassword('');
        setErrorConfirmPassword(StringManager.enterConfirmPassword);
        emit(Error());
      } else if (confirmPassword != password) {
        setErrorUsername('');
        setErrorEmail('');
        setErrorPassword('');
        setErrorConfirmPassword(StringManager.passwordNotMatch);
        emit(Error());
      } else {
        setErrorUsername('');
        setErrorEmail('');
        setErrorPassword('');
        setErrorConfirmPassword('');
        emit(Loading());
        final user = User(
          username: username,
          password: password,
          email: email,
          confirmPassword: confirmPassword,
        );

        await registerUseCase.execute(user);

        /// Registration success
        snackBar = SnackBar(
          content: Text('User register successfully...!'),
        );
        emit(Success());
      }
    } catch (e) {
      /// Handle error
      emit(Error());
      snackBar = SnackBar(
        content: Text(e.toString()),
      );
    }
  }
}

/// Method to validate email address using regex.
bool validateEmailAddress(String email) {
  return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(email);
}
