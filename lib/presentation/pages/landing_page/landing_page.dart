import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_app/presentation/bloc/login/authentication/authentication_bloc.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Landing Page"),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthenticationBloc>().add(LogOut());
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: const Center(
        child: Text("Hallo Felix"),
      ),
    );
  }
}
