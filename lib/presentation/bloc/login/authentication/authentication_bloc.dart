import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_app/infrastructure/repositories/authentication_repository_impl.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepositoryImpl authenticationRepositoryImpl;
  StreamSubscription<User?>? _authStreamSubscription;

  AuthenticationBloc({required this.authenticationRepositoryImpl})
      : super(AuthenticationInitial()) {
    /// listen to auth state changes
    _authStreamSubscription =
        authenticationRepositoryImpl.authStateChanges.listen((user) {
      if (user != null) {
        add(Authenticate());
      } else {
        add(Unauthenticate());
      }
    });

    /// log user out
    on<LogOut>((event, emit) async {
      try {
        await authenticationRepositoryImpl.logOut();
      } catch (e) {
        //TODO: handle error
      }
    });

    /// set state to authenticated
    on<Authenticate>((event, emit) => emit(Authenticated()));

    /// set state to unauthenticated
    on<Unauthenticate>((event, emit) => emit(Unauthenticated()));
  }

  @override
  Future<void> close() async {
    _authStreamSubscription?.cancel();
    return super.close();
  }
}
