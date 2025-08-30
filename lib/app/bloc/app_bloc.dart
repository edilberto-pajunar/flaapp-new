import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flaapp/model/user.dart';
import 'package:flaapp/repository/auth/auth_repository.dart';
import 'package:flaapp/repository/user/user_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final UserRepository _userRepository;
  final AuthRepository _authRepository;

  AppBloc({
    required UserRepository userRepository,
    required AuthRepository authRepository,
  })  : _userRepository = userRepository,
        _authRepository = authRepository,
        super(const AppState()) {
    on<AppInitRequested>(_onInitRequested);
    on<AppInitAuthStreamRequested>(_onInitAuthStreamRequested);
    on<AppInitUserInfoStreamRequested>(_onInitUserInfoStreamRequested);
  }

  void _onInitRequested(
    AppInitRequested event,
    Emitter<AppState> emit,
  ) {
    add(AppInitAuthStreamRequested());
  }

  void _onInitAuthStreamRequested(
    AppInitAuthStreamRequested event,
    Emitter<AppState> emit,
  ) async {
    await emit.forEach(_authRepository.user, onData: (user) {
      print(user?.uid);
      print(state.currentUserInfo?.id);
      if (user == null) return state.copyWith(currentUser: null);

      if (user.uid != state.currentUser?.uid) {
        print("This is called");
        add(AppInitUserInfoStreamRequested(user));
      }
      return state.copyWith(currentUser: user);
    });
  }

  void _onInitUserInfoStreamRequested(
    AppInitUserInfoStreamRequested event,
    Emitter<AppState> emit,
  ) async {
    await emit.forEach(
      _userRepository.userInfoStream(event.user.uid),
      onData: (userInfo) {
        return state.copyWith(
          currentUserInfo: userInfo,
        );
      },
    );
  }
}
