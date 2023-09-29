/* import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:workout_app/presentation/bloc/login/login_form/login_form_bloc.dart';
import 'package:workout_app/presentation/bloc/workout_detail/workout_detail_bloc.dart';
import 'package:workout_app/presentation/bloc/workouts_bloc/workouts_bloc.dart';
import 'infrastructure/repositories/authentication_repository_impl.dart';
import 'presentation/bloc/login/authentication/authentication_bloc.dart';
import 'presentation/bloc/login/forgot_password/forgot_password_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ###################### Authentication ######################
  // state Management
  sl.registerFactory(
      () => AuthenticationBloc(authenticationRepositoryImpl: sl()));
  sl.registerFactory(() => LoginFormBloc(authenticationRepositoryImpl: sl()));
  sl.registerFactory(
      () => ForgotPasswordBloc(authenticationRepositoryImpl: sl()));

  // Repositories
  sl.registerLazySingleton(() =>
      AuthenticationRepositoryImpl(firebaseAuth: sl(), googleSignIn: sl()));

  // External
  final firebaseAuth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  sl.registerLazySingleton(() => firebaseAuth);
  sl.registerLazySingleton(() => googleSignIn);

  // ###################### Workout detail ######################
  // state Management
  sl.registerFactory(() => WorkoutDetailBloc());

  // ###################### Workouts ######################
  sl.registerFactory(() => WorkoutsBloc());
}
 */