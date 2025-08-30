import 'package:flaapp/app/bloc/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Profile"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Email:",
                      style: theme.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      )),
                  Text(state.currentUserInfo?.email ?? ""),
                  const SizedBox(height: 12.0),
                  Text("Username:",
                      style: theme.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      )),
                  Text(state.currentUserInfo?.username ?? ""),
                  const SizedBox(height: 12.0),
                  Text("Language:",
                      style: theme.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      )),
                  Text(state.currentUserInfo?.language ?? ""),
                  const SizedBox(height: 12.0),
                  Text("Code:",
                      style: theme.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
