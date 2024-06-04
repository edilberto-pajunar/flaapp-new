part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class AuthLoginAttempted extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginAttempted({
    required this.email,
    required this.password,
  });
}

final class AuthCreateAccountAttempted extends AuthEvent {
  final String email;
  final String password;
  final String username;

  const AuthCreateAccountAttempted({
    required this.email,
    required this.password,
    required this.username,
  });
}

class AuthSignOutAttempted extends AuthEvent {}
