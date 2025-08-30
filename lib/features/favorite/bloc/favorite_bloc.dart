import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flaapp/model/word.dart';
import 'package:flaapp/repository/word/word_repository.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final WordRepository _wordRepository;

  FavoriteBloc({
    required WordRepository wordRepository,
  })  : _wordRepository = wordRepository,
        super(FavoriteState()) {
    on<FavoriteInitRequested>(_onInitRequested);
  }

  void _onInitRequested(
    FavoriteInitRequested event,
    Emitter<FavoriteState> emit,
  ) async {
    await emit.forEach(_wordRepository.getFavorites(),
        onData: (favorites) => state.copyWith(
              favorites: favorites,
            ));
  }
}
