import 'package:flaapp/features/level/bloc/level_bloc.dart';
import 'package:flaapp/repository/database/database_repository.dart';
import 'package:flaapp/repository/level/level_repository.dart';
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

  getIt.registerLazySingleton<LevelBloc>(
    () => LevelBloc(
      levelRepository: getIt<LevelRepository>(),
    ),
  );
}
