part of 'favorite_bloc.dart';

enum FavoriteStatus {
  initial,
  loading,
  success,
  failed,
}

class FavoriteState extends Equatable {
  final List<WordModel> favorites;
  final FavoriteStatus status;
  final String error;

  const FavoriteState({
    this.favorites = const [],
    this.status = FavoriteStatus.initial,
    this.error = '',
  });

  FavoriteState copyWith({
    List<WordModel>? favorites,
    FavoriteStatus? status,
    String? error,
  }) {
    return FavoriteState(
      favorites: favorites ?? this.favorites,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [favorites, status, error];
}
