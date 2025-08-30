import 'package:flaapp/admin/features/features/language/view/add_admin_language_view.dart';
import 'package:flaapp/app/app_locator.dart';
import 'package:flaapp/features/language/bloc/language_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAdminLanguagePage extends StatelessWidget {
  static const route = "/admin_add_language";
  const AddAdminLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<LanguageBloc>(),
      child: AddAdminLanguageView(),
    );
  }
}
