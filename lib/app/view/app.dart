import 'package:flaapp/app/app_router.dart';
import 'package:flaapp/app/bloc/app_bloc.dart';
import 'package:flaapp/app/view/app_view.dart';
import 'package:flaapp/cubit/lang/lang_cubit.dart';
import 'package:flaapp/features/auth/bloc/auth_bloc.dart';
import 'package:flaapp/repository/auth/auth_repository.dart';
import 'package:flaapp/repository/user/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatefulWidget {
  final AuthRepository authRepository;

  const App({
    required this.authRepository,
    super.key,
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AppRouter _appRouter =
      AppRouter(authRepository: widget.authRepository);

  @override
  Widget build(BuildContext context) {
    final AppBloc appBloc = AppBloc(
      userRepository: context.read<UserRepository>(),
      authRepository: context.read<AuthRepository>(),
    )..add(AppInitRequested());

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => appBloc,
        ),
        BlocProvider(
          create: (context) => AuthBloc(
            authRepository: context.read<AuthRepository>(),
            userRepository: context.read<UserRepository>(),
          ),
        ),
      ],
      child: AppView(_appRouter),
    );
  }
}
