import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flaapp/repository/auth/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthState()) {
    on<AuthLoginAttempted>(_onLoginAttempted);
    on<AuthCreateAccountAttempted>(_onCreateAccountAttempted);
    on<AuthSignOutAttempted>(_onSignOutAttempted);
  }

  void _onLoginAttempted(
    AuthLoginAttempted event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      await _authRepository.loginWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      emit(state.copyWith(status: AuthStatus.success));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.failed));
    }
  }

  void _onCreateAccountAttempted(
    AuthCreateAccountAttempted event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      await _authRepository.signup(
        email: event.email,
        password: event.password,
        username: event.username,
      );

      emit(state.copyWith(status: AuthStatus.success));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.failed));
    }
  }

  void _onSignOutAttempted(
    AuthSignOutAttempted event,
    Emitter<AuthState> emit,
  ) async {
    await _authRepository.signOut();
  }
}
