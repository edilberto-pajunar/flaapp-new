import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'translate_event.dart';
part 'translate_state.dart';

class TranslateBloc extends Bloc<TranslateEvent, TranslateState> {
  TranslateBloc() : super(TranslateInitial()) {
    on<TranslateEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
