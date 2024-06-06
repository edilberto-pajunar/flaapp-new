import 'package:flaapp/features/admin/bloc/admin_bloc.dart';
import 'package:flaapp/views/widgets/buttons/primary_button.dart';
import 'package:flaapp/views/widgets/fields/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddLesson extends StatelessWidget {
  const AddLesson({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController lesson = TextEditingController();

    return ListTile(
      title: const Text("Add a lesson"),
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
                      title: const Text("Add a Level"),
                      content: Column(
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
                              context
                                  .read<AdminBloc>()
                                  .add(AdminLessonStreamRequested(level: val!));
                            },
                            value: state.level,
                          ),
                          PrimaryTextField(
                            label: "Lesson",
                            controller: lesson,
                          ),
                        ],
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
