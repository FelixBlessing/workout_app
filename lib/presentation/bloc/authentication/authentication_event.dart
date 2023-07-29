part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class LogInWithEmail extends AuthenticationEvent {
  LogInWithEmail({required this.email, required this.password});
  final String email;
  final String password;
}

class LogInWithGoogle extends AuthenticationEvent {}

class LogOut extends AuthenticationEvent {}

class Authenticate extends AuthenticationEvent {}

class Unauthenticate extends AuthenticationEvent {}
