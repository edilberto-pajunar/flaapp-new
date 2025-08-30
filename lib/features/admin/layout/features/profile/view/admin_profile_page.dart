import 'package:flaapp/app/app_locator.dart';
import 'package:flaapp/features/admin/layout/features/profile/view/admin_profile_view.dart';
import 'package:flaapp/features/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminProfilePage extends StatelessWidget {
  static const route = "/admin_profile";
  const AdminProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<AuthBloc>(),
      child: AdminProfileView(),
    );
  }
}
