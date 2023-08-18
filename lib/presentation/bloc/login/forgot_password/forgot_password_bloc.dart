import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_app/infrastructure/repositories/authentication_repository_impl.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthenticationRepositoryImpl authenticationRepositoryImpl;
  ForgotPasswordBloc({required this.authenticationRepositoryImpl})
      : super(ForgotPasswordInitial()) {
    on<ForgotPasswordButtonPressed>((event, emit) async {
      try {
        await authenticationRepositoryImpl.resetPassword(email: event.email!);
        emit(RestorePasswordSuccess());
      } catch (e) {
        // TODO handle error
        emit(RestorePasswordSuccess());
      }
    });
  }
}
