part of 'forgot_password_bloc.dart';

@immutable
abstract class ForgotPasswordEvent {}

class ForgotPasswordButtonPressed extends ForgotPasswordEvent {
  ForgotPasswordButtonPressed({required this.email});
  final String? email;
}
