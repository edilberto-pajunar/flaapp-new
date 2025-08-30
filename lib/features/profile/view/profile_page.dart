import 'package:flaapp/app/app_locator.dart';
import 'package:flaapp/app/bloc/app_bloc.dart';
import 'package:flaapp/features/profile/view/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  static String route = "profile_page_route";
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<AppBloc>(),
      child: ProfileView(),
    );
  }
}
