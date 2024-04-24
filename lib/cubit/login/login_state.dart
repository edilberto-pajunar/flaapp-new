part of 'login_cubit.dart';

enum LoginStatus { initial, submitting, success, error }

class LoginState extends Equatable {
  final String email;
  final String password;
  final LoginStatus status;
  final User? user;

  const LoginState({
    required this.email,
    required this.password,
    required this.status,
    this.user,
  });

  @override
  List<Object?> get props => [email, password, user, status];

  factory LoginState.initial() {
    return const LoginState(
      email: "",
      password: "",
      status: LoginStatus.initial,
    );
  }

  LoginState copyWith({
    String? email,
    String? password,
    LoginStatus? status,
    User? user,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }
}
