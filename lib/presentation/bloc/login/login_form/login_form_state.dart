part of 'login_form_bloc.dart';

class LoginFormState {
  final bool isSubmitting;
  final AutovalidateMode showValidationMessages;
  final String? emailValidationMessage;
  final String? passwordValidationMessage;
  final String? email;
  final String? password;

  LoginFormState({
    required this.isSubmitting,
    required this.showValidationMessages,
    required this.emailValidationMessage,
    this.passwordValidationMessage,
    this.email,
    this.password,
  });

  LoginFormState copyWith({
    bool? isSubmitting,
    AutovalidateMode? showValidationMessages,
    String? emailValidationMessage,
    String? passwordValidationMessage,
    String? email,
    String? password,
  }) {
    return LoginFormState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      showValidationMessages:
          showValidationMessages ?? this.showValidationMessages,
      emailValidationMessage:
          emailValidationMessage ?? this.emailValidationMessage,
      passwordValidationMessage:
          passwordValidationMessage ?? this.passwordValidationMessage,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  factory LoginFormState.initial() {
    return LoginFormState(
      isSubmitting: false,
      showValidationMessages: AutovalidateMode.disabled,
      emailValidationMessage: null,
      passwordValidationMessage: null,
      email: null,
      password: null,
    );
  }
}
