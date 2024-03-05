part of 'register_bloc.dart';

/// Abstract class representing states related to the registration process.
@immutable
abstract class RegisterState {}

/// Initial state when the registration process starts.
class RegisterInitial extends RegisterState {}

/// State indicating that the registration process is in progress.
class Loading extends RegisterState {}

/// State indicating that the registration process was successful.
class Success extends RegisterState {}

/// State indicating that an error occurred during the registration process.
class Error extends RegisterState {}
