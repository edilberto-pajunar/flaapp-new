import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flaapp/repository/auth/auth_repository.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository _authRepository;

  SignupCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(SignupInitial());

  Future<void> signup({
    required String email,
    required String password,
  }) async {
    try {
      await _authRepository.signup(email: email, password: password);
    } catch (e) {}
  }
}
