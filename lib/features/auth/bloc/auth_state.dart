part of 'auth_bloc.dart';

enum AuthStatus { idle, loading, success, failed }

class AuthState extends Equatable {
  final User? user;
  final AuthStatus? status;

  const AuthState({
    this.user,
    this.status = AuthStatus.idle,
  });

  AuthState copyWith({
    User? user,
    AuthStatus? status,
  }) {
    return AuthState(
      user: user ?? this.user,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [user, status];
}
