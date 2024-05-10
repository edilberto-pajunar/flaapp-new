import 'package:firebase_core/firebase_core.dart';
import 'package:flaapp/bloc/auth/auth_bloc.dart';
import 'package:flaapp/bloc/level/level_bloc.dart';
import 'package:flaapp/bloc/translate/translate_bloc.dart';
import 'package:flaapp/cubit/lang/lang_cubit.dart';
import 'package:flaapp/cubit/login/login_cubit.dart';
import 'package:flaapp/cubit/signup/signup_cubit.dart';
import 'package:flaapp/l10n/l10n.dart';
import 'package:flaapp/repository/auth/auth_repository.dart';
import 'package:flaapp/repository/database/database_repository.dart';
import 'package:flaapp/repository/local/local_repository.dart';
import 'package:flaapp/repository/translate/translate_repository.dart';
import 'package:flaapp/views/screens/wrapper/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthRepository()),
        RepositoryProvider(create: (context) => DatabaseRepository()),
        RepositoryProvider(create: (context) => LocalRepository()),
        RepositoryProvider(create: (context) => TranslateRepository())
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthBloc(authRepository: context.read<AuthRepository>())),
          BlocProvider(create: (context) => LangCubit()),
          BlocProvider(
              create: (context) => LevelBloc(
                  databaseRepository: context.read<DatabaseRepository>(), authBloc: context.read<AuthBloc>())),
          BlocProvider(create: (context) => LoginCubit(authRepository: context.read<AuthRepository>())),
          BlocProvider(create: (context) => SignupCubit(authRepository: context.read<AuthRepository>())),
          BlocProvider(create: (context) => TranslateBloc(translateRepository: context.read<TranslateRepository>())),
        ],
        child: BlocBuilder<LangCubit, LangState>(
          builder: (context, state) {
            return MaterialApp(
              supportedLocales: L10n.all,
              locale: Locale(state.langType.name),
              home: const AuthWrapperScreen(),
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
            );
          },
        ),
      ),
    );
  }
}
