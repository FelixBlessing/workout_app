import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_app/infrastructure/repositories/authentication_repository_impl.dart';

part 'login_form_event.dart';
part 'login_form_state.dart';

class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  final AuthenticationRepositoryImpl authenticationRepositoryImpl;
  LoginFormBloc({required this.authenticationRepositoryImpl})
      : super(LoginFormState.initial()) {
    /// log user in with email and password
    on<LogInWithEmail>((event, emit) async {
      final validationEmailMessage = validateEmail(event.email);
      final validationPasswordMessage = validatePassword(event.password);
      if (validationEmailMessage != null || validationPasswordMessage != null) {
        emit(state.copyWith(showValidationMessages: AutovalidateMode.always));
      } else {
        emit(state.copyWith(showValidationMessages: AutovalidateMode.disabled));
        try {
          await authenticationRepositoryImpl.logInWithCredentials(
            email: event.email!,
            password: event.password!,
          );
        } catch (e) {
          //TODO: handle error
        }
      }
    });

    /// log in with google
    on<LogInWithGoogle>((event, emit) async {
      try {
        await authenticationRepositoryImpl.logInWithGoogle();
      } catch (e) {
        //TODO: handle error
      }
    });
  }

  /// validate email
  String? validateEmail(String? input) {
    const emailRegex =
        r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";

    if (input == null || input.isEmpty) {
      return "please enter email";
    } else if (RegExp(emailRegex).hasMatch(input)) {
      return null;
    } else {
      return "invalid email";
    }
  }

  /// validate password
  String? validatePassword(String? input) {
    if (input == null || input.isEmpty) {
      return "please enter password";
    } else if (input.length >= 6) {
      return null;
    } else {
      return "short password";
    }
  }
}
