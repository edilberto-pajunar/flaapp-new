import 'package:flaapp/app/app_locator.dart';
import 'package:flaapp/features/admin/layout/bloc/admin_bloc.dart';
import 'package:flaapp/features/admin/layout/features/levels/view/admin_levels_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminLevelsPage extends StatelessWidget {
  static const route = "/admin/levels";
  const AdminLevelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<AdminBloc>(),
      child: const AdminLevelsView(),
    );
  }
}
