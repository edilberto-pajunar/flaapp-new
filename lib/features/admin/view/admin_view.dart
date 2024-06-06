import 'package:flaapp/features/admin/bloc/admin_bloc.dart';
import 'package:flaapp/features/admin/widget/add_lesson.dart';
import 'package:flaapp/features/admin/widget/add_level.dart';
import 'package:flaapp/features/admin/widget/add_word.dart';
import 'package:flaapp/features/admin/widget/word_list.dart';
import 'package:flaapp/views/widgets/buttons/primary_button.dart';
import 'package:flaapp/views/widgets/fields/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class AdminView extends StatefulWidget {
  const AdminView({super.key});

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  final TextEditingController lesson = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Admin"),
          automaticallyImplyLeading: false,
          actions: [
            TextButton.icon(
              label: const Text("Choose language"),
              onPressed: () {},
              icon: const Icon(
                Icons.language,
              ),
            ),
            IconButton(
              onPressed: () {
                // context.read<AuthRepository>().signOut();
              },
              icon: const Icon(
                Icons.logout,
              ),
            ),
          ],
        ),
        body: BlocBuilder<AdminBloc, AdminState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${AppLocalizations.of(context)!.chooseALevel}:"),
                    DropdownButton<String>(
                      items: state.levels.map((level) {
                        return DropdownMenuItem(
                          value: level.label,
                          child: Text(level.label),
                        );
                      }).toList(),
                      onChanged: (val) {
                        context
                            .read<AdminBloc>()
                            .add(AdminLessonStreamRequested(level: val!));
                      },
                      value: state.level,
                    ),
                    Text("${AppLocalizations.of(context)!.chooseALesson}:"),
                    DropdownButton<String>(
                      items: state.lessons.map((lesson) {
                        return DropdownMenuItem(
                          value: lesson.label,
                          child: Text(lesson.label),
                        );
                      }).toList(),
                      onChanged: (val) {
                        context
                            .read<AdminBloc>()
                            .add(AdminWordStreamRequested(lesson: val!));
                      },
                      value: state.lesson,
                    ),
                    const AddLevel(),
                    const Divider(),
                    const AddLesson(),
                    const Divider(),
                    const AddWord(),
                    const Divider(),
                    const SizedBox(height: 24.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "List of Words from ${state.level ?? ""}-${state.lesson ?? ""}",
                            style: theme.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    WordList(
                      state: state,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
