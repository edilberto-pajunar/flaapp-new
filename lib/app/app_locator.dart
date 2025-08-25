import 'package:flaapp/features/lesson/bloc/lesson_bloc.dart';
import 'package:flaapp/features/level/bloc/level_bloc.dart';
import 'package:flaapp/features/word/bloc/word_bloc.dart';
import 'package:flaapp/repository/database/database_repository.dart';
import 'package:flaapp/repository/lesson/lesson_repository.dart';
import 'package:flaapp/repository/level/level_repository.dart';
import 'package:flaapp/repository/word/word_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerLazySingleton<DatabaseRepository>(
    () => DatabaseRepository(),
  );

  getIt.registerLazySingleton<LevelRepository>(
    () => LevelRepository(
      databaseRepository: getIt<DatabaseRepository>(),
    ),
  );

  getIt.registerLazySingleton<LessonRepository>(
    () => LessonRepository(
      databaseRepository: getIt<DatabaseRepository>(),
    ),
  );

  getIt.registerLazySingleton<WordRepository>(
    () => WordRepository(
      databaseRepository: getIt<DatabaseRepository>(),
    ),
  );

  getIt.registerLazySingleton<LevelBloc>(
    () => LevelBloc(
      levelRepository: getIt<LevelRepository>(),
    ),
  );

  getIt.registerLazySingleton<LessonBloc>(
    () => LessonBloc(
      lessonRepository: getIt<LessonRepository>(),
    ),
  );

  getIt.registerLazySingleton<WordBloc>(
    () => WordBloc(
      wordRepository: getIt<WordRepository>(),
      lessonRepository: getIt<LessonRepository>(),
    ),
  );
}
