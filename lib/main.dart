import 'package:firebase_core/firebase_core.dart';
import 'package:flaapp/bloc/auth/auth_bloc.dart';
import 'package:flaapp/bloc/word/word_bloc.dart';
import 'package:flaapp/cubit/login/login_cubit.dart';
import 'package:flaapp/cubit/signup/signup_cubit.dart';
import 'package:flaapp/repository/auth/auth_repository.dart';
import 'package:flaapp/repository/database/database_repository.dart';
import 'package:flaapp/services/networks/admin.dart';
import 'package:flaapp/services/networks/auth.dart';
import 'package:flaapp/services/networks/word.dart';
import 'package:flaapp/views/screens/wrapper/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

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
        RepositoryProvider(create: (context) => DatabaseRepository())
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LoginCubit(authRepository: context.read<AuthRepository>())),
          BlocProvider(create: (context) => AuthBloc(authRepository: context.read<AuthRepository>())),
          BlocProvider(create: (context) => SignupCubit(authRepository: context.read<AuthRepository>())),
          BlocProvider(
              create: (context) =>
                  WordBloc(authBloc: context.read<AuthBloc>(), databaseRepository: context.read<DatabaseRepository>())
                    ..add(LoadUserWords(userId: context.read<AuthBloc>().state.user!.uid))),
        ],
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<Admin>(create: (context) => Admin()),
            ChangeNotifierProvider<Auth>(create: (context) => Auth()),
            ChangeNotifierProvider<Word>(create: (context) => Word()),
          ],
          child: const MaterialApp(
            home: AuthWrapperScreen(),
          ),
        ),
      ),
    );
  }
}
