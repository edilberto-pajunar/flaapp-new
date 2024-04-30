import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flaapp/repository/auth/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(LoginState.initial());

  Future<void> loginWithCredentials({
    required String email,
    required String password,
  }) async {
    if (state.status == LoginStatus.submitting) {
      emit(state.copyWith(status: LoginStatus.submitting));
    }

    try {
      await _authRepository.loginWithEmailAndPassword(email: email, password: password);

      emit(state.copyWith(status: LoginStatus.success));
    } catch (e) {
      print("Error: $e");
    }
  }
}
