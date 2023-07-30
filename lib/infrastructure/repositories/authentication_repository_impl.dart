import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:workout_app/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl({
    required this.firebaseAuth,
    required this.googleSignIn,
  });

  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  /// Returns the current user.
  @override
  User? getUser() {
    return firebaseAuth.currentUser;
  }

  /// Returns a stream of [User] which will emit the current user when
  /// the authentication state changes.
  @override
  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  @override
  Future<UserCredential> logInWithCredentials(
      {required String email, required String password}) async {
    final user = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return user;
  }

  /// Logs the user in with Google.
  @override
  Future<void> logInWithGoogle() async {
    // Erstelle einen GoogleSignIn-Kontext.
    final googleSignIn = GoogleSignIn();

    // Versuche, sich mit dem Google-Konto des Benutzers anzumelden.
    final googleUser = await googleSignIn.signIn();

    // Wenn sich der Benutzer erfolgreich angemeldet hat, erstelle einen Auth-Benutzer.
    if (googleUser != null) {
      final googleAuthentication = await googleUser.authentication;
      final googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuthentication.accessToken,
        idToken: googleAuthentication.idToken,
      );
      await firebaseAuth.signInWithCredential(googleCredential);
    }
  }

  /// Logs the user out.
  @override
  Future<void> logOut() async {
    await firebaseAuth.signOut();
  }

  Future<void> resetPassword({required String email}) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
