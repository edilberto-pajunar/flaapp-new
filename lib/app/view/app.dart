import 'package:flaapp/app/app_locator.dart';
import 'package:flaapp/app/app_router.dart';
import 'package:flaapp/app/bloc/app_bloc.dart';
import 'package:flaapp/app/view/app_view.dart';
import 'package:flaapp/features/auth/bloc/auth_bloc.dart';
import 'package:flaapp/repository/auth/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatefulWidget {
  const App({
    super.key,
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AppRouter _appRouter = AppRouter(
    authRepository: getIt<AuthRepository>(),
  );

  @override
  Widget build(BuildContext context) {
    // final AppBloc appBloc = AppBloc(
    //   userRepository: context.read<UserRepository>(),
    //   authRepository: context.read<AuthRepository>(),
    // )..add(AppInitRequested());

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: getIt<AppBloc>(),
        ),
        BlocProvider.value(
          value: getIt<AuthBloc>(),
        ),
      ],
      child: AppView(appRouter: _appRouter),
    );
  }
}
