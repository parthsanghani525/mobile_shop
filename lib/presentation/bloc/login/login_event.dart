part of 'login_bloc.dart';

/// Abstract class representing events related to the login process.
@immutable
abstract class LoginEvent {}

/// Event indicating that the login button is pressed.
class LoginButtonPressEvent extends LoginEvent {}
