import 'package:flaapp/admin/features/features/language/view/admin_language_page.dart';
import 'package:flaapp/features/auth/bloc/auth_bloc.dart';
import 'package:flaapp/utils/constant/strings/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AdminProfileView extends StatelessWidget {
  const AdminProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Column(
        children: [
          Divider(),
          ListTile(
            title: Text("Languages"),
            leading: Icon(Icons.language),
            onTap: () {
              context.pushNamed(AdminLanguagePage.route);
            },
          ),
          ListTile(
            title: Text("Logout"),
            leading: Icon(Icons.logout),
            onTap: () {
              context.read<AuthBloc>().add(AuthSignOutAttempted());
            },
          ),
        ],
      ),
    );
  }
}
