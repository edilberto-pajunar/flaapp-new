part of 'app_bloc.dart';

final class AppState extends Equatable {
  final AppUserInfo? currentUserInfo;
  final User? currentUser;

  const AppState({
    this.currentUserInfo,
    this.currentUser,
  });

  AppState copyWith({
    AppUserInfo? currentUserInfo,
    User? currentUser,
  }) {
    return AppState(
      currentUserInfo: currentUserInfo ?? this.currentUserInfo,
      currentUser: currentUser ?? this.currentUser,
    );
  }

  @override
  List<Object?> get props => [
        currentUserInfo,
        currentUser,
      ];
}
