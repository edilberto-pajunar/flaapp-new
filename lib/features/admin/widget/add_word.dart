import 'package:flaapp/features/admin/bloc/admin_bloc.dart';
import 'package:flaapp/views/widgets/buttons/primary_button.dart';
import 'package:flaapp/views/widgets/fields/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddWord extends StatefulWidget {
  const AddWord({
    super.key,
  });

  @override
  State<AddWord> createState() => _AddWordState();
}

class _AddWordState extends State<AddWord> {
  final TextEditingController word = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text("Add a word"),
      trailing: const Icon(Icons.arrow_forward),
      onTap: () {
        showDialog(
            context: context,
            builder: (_) {
              return BlocProvider.value(
                value: context.read<AdminBloc>(),
                child: BlocBuilder<AdminBloc, AdminState>(
                  builder: (context, state) {
                    return AlertDialog(
                      title: const Text("Add a Word"),
                      content: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            DropdownButton<String>(
                              items: state.levels.map((level) {
                                return DropdownMenuItem(
                                  value: level.label,
                                  child: Text(level.label),
                                );
                              }).toList(),
                              onChanged: (val) {
                                context.read<AdminBloc>().add(
                                    AdminLessonStreamRequested(level: val!));
                              },
                              value: state.level,
                            ),
                            const SizedBox(height: 12.0),
                            DropdownButton<String>(
                              items: state.lessons.map((level) {
                                return DropdownMenuItem(
                                  value: level.label,
                                  child: Text(level.label),
                                );
                              }).toList(),
                              onChanged: (val) {
                                context.read<AdminBloc>().add(
                                    AdminWordStreamRequested(lesson: val!));
                              },
                              value: state.lesson,
                            ),
                            PrimaryTextField(
                              label: "Word",
                              controller: word,
                            ),
                            TextButton(
                              onPressed: () => context
                                  .read<AdminBloc>()
                                  .add(AdminTranslateWordRequested(
                                    word: word.text,
                                  )),
                              child: const Text("Translate"),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PrimaryTextField(
                                  controller: TextEditingController(
                                    text: state.translatedWords.isEmpty
                                        ? "English"
                                        : state.translatedWords[0],
                                  ),
                                  onChanged: (val) {
                                    context
                                        .read<AdminBloc>()
                                        .add(AdminWordChanged(word: val));
                                  },
                                  label: "English",
                                ),
                                PrimaryTextField(
                                  controller: TextEditingController(
                                    text: state.translatedWords.isEmpty
                                        ? "German"
                                        : state.translatedWords[1],
                                  ),
                                  label: "German",
                                ),
                                PrimaryTextField(
                                  controller: TextEditingController(
                                    text: state.translatedWords.isEmpty
                                        ? "Spanish"
                                        : state.translatedWords[2],
                                  ),
                                  label: "Spanish",
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        PrimaryButton(
                          label: "Add",
                          onTap: () {},
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Cancel"),
                        ),
                      ],
                    );
                  },
                ),
              );
            });
      },
    );
  }
}
