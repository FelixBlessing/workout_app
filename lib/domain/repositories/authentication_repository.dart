import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRepository {
  Future<void> logInWithCredentials(
      {required String email, required String password});

  Future<void> logInWithGoogle();

  Future<void> logOut();

  User? getUser();

  Stream<User?> get authStateChanges;
}
