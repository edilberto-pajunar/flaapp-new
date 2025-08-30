import 'package:flaapp/admin/features/bloc/admin_bloc.dart';
import 'package:flaapp/admin/features/features/levels/view/add_admin_level_view.dart';
import 'package:flaapp/app/app_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAdminLevelPage extends StatelessWidget {
  static const route = "/admin_add_level";
  const AddAdminLevelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<AdminBloc>(),
      child: const AddAdminLevelView(),
    );
  }
}
