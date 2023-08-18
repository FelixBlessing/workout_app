part of 'login_form_bloc.dart';

@immutable
abstract class LoginFormEvent {}

class ValidateEmail extends LoginFormEvent {
  ValidateEmail({required this.email});
  final String? email;
}

class ValidatePassword extends LoginFormEvent {
  ValidatePassword({required this.password});
  final String? password;
}

class LogInWithEmail extends LoginFormEvent {
  LogInWithEmail({required this.email, required this.password});
  final String email;
  final String password;
}

class LogInWithGoogle extends LoginFormEvent {}

class TogglePasswordVisibility extends LoginFormEvent {}

class ResetErrorMessage extends LoginFormEvent {}
