part of 'login_form_bloc.dart';

class LoginFormState {
  final bool showPassword;
  final SubmittingType submittingType;
  final AutovalidateMode showValidationMessages;
  final String? emailValidationMessage;
  final String? passwordValidationMessage;

  LoginFormState({
    required this.showPassword,
    required this.submittingType,
    required this.showValidationMessages,
    required this.emailValidationMessage,
    this.passwordValidationMessage,
  });

  LoginFormState copyWith({
    bool? showPassword,
    SubmittingType? submittingType,
    AutovalidateMode? showValidationMessages,
    String? emailValidationMessage,
    String? passwordValidationMessage,
  }) {
    return LoginFormState(
      showPassword: showPassword ?? this.showPassword,
      submittingType: submittingType ?? this.submittingType,
      showValidationMessages:
          showValidationMessages ?? this.showValidationMessages,
      emailValidationMessage:
          emailValidationMessage ?? this.emailValidationMessage,
      passwordValidationMessage:
          passwordValidationMessage ?? this.passwordValidationMessage,
    );
  }

  factory LoginFormState.initial() {
    return LoginFormState(
      showPassword: false,
      submittingType: SubmittingType.none,
      showValidationMessages: AutovalidateMode.disabled,
      emailValidationMessage: null,
      passwordValidationMessage: null,
    );
  }
}

enum SubmittingType { email, google, none }
