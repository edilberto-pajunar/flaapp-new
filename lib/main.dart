import 'package:firebase_core/firebase_core.dart';
import 'package:flaapp/app/app_bloc_observer.dart';
import 'package:flaapp/app/app_locator.dart';
import 'package:flaapp/app/view/app.dart';
import 'package:flaapp/cubit/lang/lang_cubit.dart';
import 'package:flaapp/repository/auth/auth_repository.dart';
import 'package:flaapp/repository/database/database_repository.dart';
import 'package:flaapp/repository/lesson/lesson_repository.dart';
import 'package:flaapp/repository/level/level_repository.dart';
import 'package:flaapp/repository/local/local_repository.dart';
import 'package:flaapp/repository/translate/translate_repository.dart';
import 'package:flaapp/repository/user/user_repository.dart';
import 'package:flaapp/repository/word/word_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Bloc.observer = AppBlocObserver();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => DatabaseRepository()),
        RepositoryProvider(create: (context) => LocalRepository()),
        RepositoryProvider(create: (context) => TranslateRepository()),
        RepositoryProvider(
          create: (context) => LessonRepository(
            databaseRepository: context.read<DatabaseRepository>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => LevelRepository(
            databaseRepository: context.read<DatabaseRepository>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => WordRepository(
            databaseRepository: context.read<DatabaseRepository>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => UserRepository(
            databaseRepository: context.read<DatabaseRepository>(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          // BlocProvider(
          //   create: (context) => TranslateBloc(
          //       translateRepository: context.read<TranslateRepository>()),
          // ),
          BlocProvider(
            create: (context) => LangCubit(),
          ),
        ],
        child: App(),
      ),
    );
  }
}
