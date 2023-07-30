import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:workout_app/constants.dart';
import 'package:workout_app/dependency_injection.dart';
import 'package:workout_app/presentation/bloc/login/login_form/login_form_bloc.dart';

const creamWhite = Color.fromARGB(255, 252, 251, 244);

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
                child: LoginHeader(),
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

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});
  final TextStyle _textStyleBig = const TextStyle(
    color: creamWhite,
    fontSize: 34,
    fontWeight: FontWeight.bold,
  );
  final TextStyle _textStyleSmall = const TextStyle(
    color: creamWhite,
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: kBigPadding, bottom: kHugePadding),
      color: const Color.fromARGB(255, 10, 30, 46),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('Sign in to your\nAccount', style: _textStyleBig),
          Text(
            'Sign in to your Account',
            style: _textStyleSmall,
          ),
        ],
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
                    onPressed: () {},
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
                      onPressed: () {},
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

class ButtonLoadingSpinner extends StatelessWidget {
  const ButtonLoadingSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 24,
      height: 24,
      child: CircularProgressIndicator(),
    );
  }
}
