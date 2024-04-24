part of 'auth_bloc.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState extends Equatable {
  final User? user;
  final AuthStatus? status;

  const AuthState._({
    this.user,
    this.status = AuthStatus.unknown,
  });

  const AuthState.unknown() : this._();

  const AuthState.authenticated({
    required User user,
  }) : this._(
          status: AuthStatus.authenticated,
          user: user,
        );

  const AuthState.unauthenticated()
      : this._(
          status: AuthStatus.unauthenticated,
        );

  @override
  List<Object?> get props => [user, status];
}
