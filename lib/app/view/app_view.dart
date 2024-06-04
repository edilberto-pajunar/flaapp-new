import 'package:flaapp/app/app_router.dart';
import 'package:flaapp/cubit/lang/lang_cubit.dart';
import 'package:flaapp/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppView extends StatelessWidget {
  final AppRouter appRouter;

  const AppView(this.appRouter, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LangCubit, LangState, String>(
      selector: (state) => state.langType.name,
      builder: (context, lang) {
        return MaterialApp.router(
          supportedLocales: L10n.all,
          routerConfig: appRouter.config,
          locale: Locale(lang),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        );
      },
    );
  }
}
