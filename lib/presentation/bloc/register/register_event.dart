part of 'register_bloc.dart';

/// Abstract class representing events related to the registration process.
@immutable
abstract class RegisterEvent {}

/// Event indicating that the user wants to register.
class Register extends RegisterEvent {}
