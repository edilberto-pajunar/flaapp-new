import 'package:flaapp/features/admin/layout/bloc/admin_bloc.dart';
import 'package:flaapp/features/admin/layout/features/lessons/view/admin_lessons_page.dart';
import 'package:flaapp/features/admin/layout/features/profile/view/admin_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AdminLevelsView extends StatefulWidget {
  const AdminLevelsView({
    super.key,
  });

  @override
  State<AdminLevelsView> createState() => _AdminLevelsViewState();
}

class _AdminLevelsViewState extends State<AdminLevelsView> {
  @override
  void initState() {
    super.initState();
    context.read<AdminBloc>().add(AdminLevelStreamRequested());
    context.read<AdminBloc>().add(AdminLanguageStreamRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => context.pushNamed(AdminProfilePage.route),
            child: CircleAvatar(
              child: Icon(
                Icons.person,
              ),
            ),
          ),
        ),
        title: Text("Levels"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: BlocConsumer<AdminBloc, AdminState>(
        bloc: context.read<AdminBloc>(),
        listenWhen: (prev, curr) => prev.adminStatus != curr.adminStatus,
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) => Divider(),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.levels.length,
              itemBuilder: (context, index) {
                final level = state.levels[index];
                return Row(
                  children: [
                    Expanded(
                      child: Text(level.label ?? ""),
                    ),
                    IconButton(
                      onPressed: () {
                        context
                            .pushNamed(AdminLessonsPage.route, pathParameters: {
                          "level_id": level.id ?? "",
                        }, extra: {
                          "levelLabel": level.label ?? "",
                        });
                      },
                      icon: Icon(
                        Icons.arrow_right_alt,
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
