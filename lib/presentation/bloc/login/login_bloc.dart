import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecases/login_usecase.dart';
import '../../../resource/strings_manager.dart';

part 'login_event.dart';
part 'login_state.dart';

/// Bloc responsible for handling the logic related to user login.
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;
  String username = '';
  String password = '';

  String errorPassword = '';
  String errorName = '';

  /// Setter methods for updating the username, password, and error messages.
  void setUsername(String value) => username = value;

  void setPassword(String value) => password = value;

  void setErrorUsername(String value) => errorName = value;

  void setErrorPassword(String value) => errorPassword = value;

  /// Snackbar for displaying feedback messages.
  SnackBar? snackBar;

  /// Constructor for the LoginBloc.
  LoginBloc(this.loginUseCase) : super(LoginInitial()) {
    on<LoginButtonPressEvent>(_loginButtonPressEvent);
  }

  /// Logic for handling the login button press event.
  void _loginButtonPressEvent(
      LoginButtonPressEvent event, Emitter<LoginState> emit) async {
    try {
      if (checkTextField(value: username)) {
        setErrorUsername(StringManager.enterName);
        emit(LoginError());
      } else if (checkTextField(value: password)) {
        setErrorUsername('');
        setErrorPassword(StringManager.enterPassword);
        emit(LoginError());
      } else {
        emit(LoginLoading());
        setErrorUsername('');
        setErrorPassword('');
        final user = await loginUseCase.execute(username, password);
        if (user != null) {
          emit(LoginSuccess());
        }else{
          snackBar = SnackBar(
            content: Text('User not register...!'),
          );
          emit(LoginError());
        }
      }
    } catch (e) {
      snackBar = SnackBar(
        content: Text(e.toString()),
      );
      emit(LoginError());
    }
  }
}

/// Function to check if a text field is empty.
bool checkTextField({required String value}) {
  return value.isEmpty;
}
