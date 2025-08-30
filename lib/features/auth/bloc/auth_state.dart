part of 'auth_bloc.dart';

enum AuthStatus { idle, loading, success, failed }

class AuthState extends Equatable {
  final User? user;
  final AuthStatus? status;
  final String? error;

  const AuthState({
    this.user,
    this.status = AuthStatus.idle,
    this.error,
  });

  AuthState copyWith({
    User? user,
    AuthStatus? status,
    String? error,
  }) {
    return AuthState(
      user: user ?? this.user,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        user,
        status,
        error,
      ];
}
