import 'package:flaapp/admin/features/bloc/admin_bloc.dart';
import 'package:flaapp/admin/features/features/words/view/add_word_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AdminWordsView extends StatefulWidget {
  const AdminWordsView({
    required this.levelId,
    required this.lessonId,
    super.key,
  });

  final String levelId;
  final String lessonId;

  @override
  State<AdminWordsView> createState() => _AdminWordsViewState();
}

class _AdminWordsViewState extends State<AdminWordsView> {
  @override
  void initState() {
    super.initState();
    context.read<AdminBloc>().add(AdminWordStreamRequested(
        levelId: widget.levelId, lessonId: widget.lessonId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed(AdminAddWordPage.route, pathParameters: {
                "level_id": widget.levelId,
                "lesson_id": widget.lessonId,
              });
            },
            icon: Icon(Icons.add),
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
            child: state.words.isEmpty
                ? const Center(child: Text("No words found"))
                : ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => Divider(),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.words.length,
                    itemBuilder: (context, index) {
                      final word = state.words[index];
                      final itemNumber = index + 1;
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text("$itemNumber. ${word.word ?? ""}"),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12.0),
                          ...word.translations?.map((translation) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(translation.language ?? ""),
                                      ),
                                      Expanded(
                                        child: Text(translation.word ?? ""),
                                      ),
                                    ],
                                  ),
                                );
                              }) ??
                              [],
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
