import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:workout_app/presentation/bloc/login/login_form/login_form_bloc.dart';
import 'infrastructure/repositories/authentication_repository_impl.dart';
import 'presentation/bloc/login/authentication/authentication_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ###################### Authentication ######################
  // state Management
  sl.registerFactory(
      () => AuthenticationBloc(authenticationRepositoryImpl: sl()));
  sl.registerFactory(() => LoginFormBloc(authenticationRepositoryImpl: sl()));

  // Repositories
  sl.registerLazySingleton(() =>
      AuthenticationRepositoryImpl(firebaseAuth: sl(), googleSignIn: sl()));

  // External
  final firebaseAuth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  sl.registerLazySingleton(() => firebaseAuth);
  sl.registerLazySingleton(() => googleSignIn);
}
