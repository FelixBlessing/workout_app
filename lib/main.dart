import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:workout_app/infrastructure/repositories/authentication_repository_impl.dart';
import 'package:workout_app/infrastructure/repositories/workout_repository_impl.dart';
import 'package:workout_app/presentation/pages/root_page/root_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Dependency Injection
  runApp(const WorkoutApp());
}

class WorkoutApp extends StatelessWidget {
  const WorkoutApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<WorkoutRepositoryImpl>(
          create: (context) => WorkoutRepositoryImpl(),
        ),
        RepositoryProvider(
          create: (context) => AuthenticationRepositoryImpl(
            firebaseAuth: FirebaseAuth.instance,
            googleSignIn: GoogleSignIn(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Workout App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const RootPage(),
      ),
    );
  }
}
