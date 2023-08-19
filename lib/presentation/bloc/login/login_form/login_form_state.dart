part of 'login_form_bloc.dart';

class LoginFormState {
  final bool showPassword;
  final bool showSignUpBottomSheet;
  final SubmittingType submittingType;
  final AutovalidateMode showValidationMessages;
  final String? errorMessage;

  LoginFormState({
    required this.showPassword,
    required this.showSignUpBottomSheet,
    required this.submittingType,
    required this.showValidationMessages,
    this.errorMessage,
  });

  LoginFormState copyWith({
    bool? showPassword,
    bool? showSignUpBottomSheet,
    SubmittingType? submittingType,
    AutovalidateMode? showValidationMessages,
    String? errorMessage,
  }) {
    return LoginFormState(
      showPassword: showPassword ?? this.showPassword,
      showSignUpBottomSheet:
          showSignUpBottomSheet ?? this.showSignUpBottomSheet,
      submittingType: submittingType ?? this.submittingType,
      showValidationMessages:
          showValidationMessages ?? this.showValidationMessages,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  factory LoginFormState.initial() {
    return LoginFormState(
      showPassword: false,
      showSignUpBottomSheet: false,
      submittingType: SubmittingType.none,
      showValidationMessages: AutovalidateMode.disabled,
      errorMessage: null,
    );
  }
}

enum SubmittingType { email, google, none }
