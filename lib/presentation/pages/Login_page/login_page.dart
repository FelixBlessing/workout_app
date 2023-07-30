import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:workout_app/constants.dart';
import 'package:workout_app/dependency_injection.dart';
import 'package:workout_app/presentation/bloc/login/forgot_password/forgot_password_bloc.dart';
import 'package:workout_app/presentation/bloc/login/login_form/login_form_bloc.dart';
import 'package:workout_app/presentation/pages/Login_page/sign_up_page.dart';

import 'widgets/button_loading_spinner.dart';
import 'widgets/login_header.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight,
          child: const Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                flex: 1,
                child: LoginHeader(
                  heading: 'Sign in to your\nAccount',
                  subHeading: 'Sign in to your Account',
                ),
              ),
              Flexible(
                flex: 2,
                child: _LoginForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LoginFormBloc>(),
      child: BlocBuilder<LoginFormBloc, LoginFormState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: kBigPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: kDefaultPadding),
                Form(
                  autovalidateMode: state.showValidationMessages,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        validator: context.read<LoginFormBloc>().validateEmail,
                        focusNode: emailFocusNode,
                        keyboardType: TextInputType.emailAddress,
                        onTapOutside: (event) => emailFocusNode.unfocus(),
                        onFieldSubmitted: (value) {
                          emailFocusNode.unfocus();
                          passwordFocusNode.requestFocus();
                        },
                        decoration: const InputDecoration(
                          hintText: 'test@email.com',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(),
                          label: Text("Email"),
                          alignLabelWithHint: true,
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                      const SizedBox(height: kBigPadding),
                      TextFormField(
                        controller: passwordController,
                        validator:
                            context.read<LoginFormBloc>().validatePassword,
                        focusNode: passwordFocusNode,
                        keyboardType: TextInputType.visiblePassword,
                        onTapOutside: (event) =>
                            FocusScope.of(context).unfocus(),
                        onFieldSubmitted: (value) {
                          passwordFocusNode.unfocus();
                          context.read<LoginFormBloc>().add(
                                LogInWithEmail(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                              );
                        },
                        obscureText: !state.showPassword,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          label: const Text("Password"),
                          alignLabelWithHint: true,
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () {
                              context
                                  .read<LoginFormBloc>()
                                  .add(TogglePasswordVisibility());
                            },
                            icon: state.showPassword
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: const ForgotPassword(),
                          );
                        },
                      );
                    },
                    child: const Text('Forgot Password?'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<LoginFormBloc>().add(
                          LogInWithEmail(
                            email: emailController.text,
                            password: passwordController.text,
                          ),
                        );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: state.submittingType == SubmittingType.email
                      ? const ButtonLoadingSpinner()
                      : const Text(
                          'Login',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                ),
                const SizedBox(height: kDefaultPadding),
                const Row(
                  children: [
                    Expanded(
                      child: Divider(thickness: 2),
                    ),
                    SizedBox(width: kSmallPadding),
                    Text("Or Login with"),
                    SizedBox(width: kSmallPadding),
                    Expanded(
                      child: Divider(thickness: 2),
                    ),
                  ],
                ),
                const SizedBox(height: kDefaultPadding),
                OutlinedButton(
                  onPressed: () {
                    context.read<LoginFormBloc>().add(LogInWithGoogle());
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: state.submittingType == SubmittingType.google
                      ? const ButtonLoadingSpinner()
                      : const FaIcon(FontAwesomeIcons.google),
                ),
                const SizedBox(height: kDefaultPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        /* showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return const SignUpPage();
                          },
                        ); */
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpPage()));
                      },
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ForgotPasswordBloc>(),
      child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(kBigPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text('Enter your email to reset your password',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    )),
                const SizedBox(height: kBigPadding),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  onFieldSubmitted: (value) {
                    context.read<ForgotPasswordBloc>().add(
                        ForgotPasswordButtonPressed(
                            email: emailController.text));
                    Navigator.pop(context);
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Email"),
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: kBigPadding),
                ElevatedButton(
                  onPressed: () {
                    context.read<ForgotPasswordBloc>().add(
                        ForgotPasswordButtonPressed(
                            email: emailController.text));
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text(
                    'Send Reset Link',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
