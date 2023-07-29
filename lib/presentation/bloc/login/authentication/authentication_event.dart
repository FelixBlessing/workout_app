part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class LogOut extends AuthenticationEvent {}

class Authenticate extends AuthenticationEvent {}

class Unauthenticate extends AuthenticationEvent {}
