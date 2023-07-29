import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_app/dependency_injection.dart';
import 'package:workout_app/presentation/pages/Login_page/login_page.dart';
import 'package:workout_app/presentation/pages/landing_page/landing_page.dart';
import 'package:workout_app/presentation/bloc/login/authentication/authentication_bloc.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthenticationBloc>(),
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationInitial) {
            return const Loading();
          } else if (state is Authenticated) {
            return const LandingPage();
          } else if (state is Unauthenticated) {
            return const LoginPage();
          } else {
            return const Error();
          }
        },
      ),
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class Error extends StatelessWidget {
  const Error({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Something went wrong"),
      ),
    );
  }
}
