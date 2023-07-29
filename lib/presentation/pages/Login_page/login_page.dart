import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_app/presentation/bloc/authentication/authentication_bloc.dart';

const creamWhite = Color.fromARGB(255, 252, 251, 244);
const _bigPadding = 24.0;
const _defaultPadding = 16.0;
const _smallPadding = 12.0;
const _hugePadding = 40.0;

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeigh = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeigh,
          child: const Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                flex: 1,
                child: LoginHeader(),
              ),
              Flexible(
                flex: 2,
                child: LoginForm(),
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
      padding: const EdgeInsets.only(left: _bigPadding, bottom: _hugePadding),
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

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: _bigPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: _defaultPadding),
          Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'test@email.com',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                    label: Text("Email"),
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: _bigPadding),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Password"),
                    alignLabelWithHint: true,
                    suffixIcon: Icon(Icons.remove_red_eye_outlined),
                  ),
                ),
              ],
            ),
          ),
          //const SizedBox(height: _smallPadding),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: const Text('Forgot Password?'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AuthenticationBloc>().add(LogInWithEmail());
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
            ),
            child: const Text('Login'),
          ),
          const SizedBox(height: _defaultPadding),
          const Row(
            children: [
              Expanded(
                child: Divider(),
              ),
              Text("Or Login with"),
              Expanded(
                child: Divider(),
              ),
            ],
          ),
          const SizedBox(height: _defaultPadding),
          OutlinedButton(
            onPressed: () {
              context.read<AuthenticationBloc>().add(LogInWithGoogle());
            },
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
            ),
            child: const Text('Google'),
          ),
          const SizedBox(height: _defaultPadding),
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
  }
}
