import 'package:flaapp/admin/features/bloc/admin_bloc.dart';
import 'package:flaapp/admin/features/features/words/view/admin_words_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AdminLessonsView extends StatefulWidget {
  const AdminLessonsView({
    required this.levelId,
    required this.levelLabel,
    super.key,
  });

  final String levelId;
  final String levelLabel;

  @override
  State<AdminLessonsView> createState() => _AdminLessonsViewState();
}

class _AdminLessonsViewState extends State<AdminLessonsView> {
  @override
  void initState() {
    super.initState();
    context
        .read<AdminBloc>()
        .add(AdminLessonStreamRequested(levelId: widget.levelId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.levelLabel} Lessons"),
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
        listenWhen: (prev, curr) => prev.adminStatus != curr.adminStatus,
        listener: (context, state) {
          // if (state.adminStatus == AdminStatus.loading) {
          //   context.pop();
          // }
        },
        builder: (context, state) {
          if (state.adminStatus == AdminStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: state.lessons.isEmpty
                ? const Center(child: Text("No lessons found"))
                : ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => Divider(),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.lessons.length,
                    itemBuilder: (context, index) {
                      final lesson = state.lessons[index];
                      return Row(
                        children: [
                          Expanded(
                            child: Text(lesson.label ?? ""),
                          ),
                          IconButton(
                            onPressed: () {
                              context.pushNamed(AdminWordsPage.route,
                                  pathParameters: {
                                    "level_id": widget.levelId,
                                    "lesson_id": lesson.id ?? "",
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
