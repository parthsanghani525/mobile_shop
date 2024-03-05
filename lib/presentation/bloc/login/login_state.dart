part of 'login_bloc.dart';

/// Abstract class representing states related to the login process.
@immutable
abstract class LoginState {}

/// Initial state when the login process starts.
class LoginInitial extends LoginState {}

/// State indicating that the login process is in progress.
class LoginLoading extends LoginState {}

/// State indicating that the login process was successful.
class LoginSuccess extends LoginState {}

/// State indicating that an error occurred during the login process.
class LoginError extends LoginState {}
