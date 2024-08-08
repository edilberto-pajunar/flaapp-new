import 'package:flaapp/features/admin/layout/bloc/admin_bloc.dart';
import 'package:flaapp/model/level.dart';
import 'package:flaapp/values/constant/theme/colors.dart';
import 'package:flaapp/views/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';

class AdminLessons extends StatefulWidget {
  const AdminLessons({
    super.key,
  });

  @override
  State<AdminLessons> createState() => _AdminLessonsState();
}

class _AdminLessonsState extends State<AdminLessons> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminBloc, AdminState>(
      listenWhen: (prev, curr) => prev.adminStatus != curr.adminStatus,
      listener: (context, state) {
        if (state.adminStatus == AdminStatus.loading) {
          context.pop();
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("LESSONS"),
                PrimaryButton(
                  label: "Add a lesson",
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: const Text("Add a level"),
                          content: FormBuilder(
                            key: _formKey,
                            onChanged: () => _formKey.currentState!.save(),
                            child: FormBuilderTextField(
                              name: "lesson",
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return "This field is required";
                                }
                                return null;
                              },
                            ),
                          ),
                          actions: [
                            PrimaryButton(
                              label: "Add",
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AdminBloc>().add(
                                        AdminAddLessonSubmitted(
                                          lesson: _formKey
                                              .currentState!.value["lesson"],
                                          level: state.level!,
                                        ),
                                      );
                                }
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Expanded(
              child: GridView.builder(
                itemCount: state.lessons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 12.0,
                  crossAxisSpacing: 12.0,
                ),
                itemBuilder: (context, index) {
                  final lesson = state.lessons[index];
                  return Container(
                    padding: const EdgeInsets.all(12.0),
                    color: Colors.grey.shade300,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              style: IconButton.styleFrom(
                                backgroundColor: ColorTheme.tWhiteColor,
                              ),
                              icon: Icon(
                                Icons.delete,
                                color: ColorTheme.tRedColor,
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (_) {
                                    return AlertDialog(
                                      title: const Text("Are you sure?"),
                                      content: const Text(
                                          "This action cannot be undone."),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            context
                                                .read<AdminBloc>()
                                                .add(AdminDeleteLessonRequested(
                                                  lesson.id,
                                                ));
                                          },
                                          child: const Text("Yes"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("No"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            const SizedBox(width: 4.0),
                            IconButton(
                              style: IconButton.styleFrom(
                                backgroundColor: ColorTheme.tBlueColor,
                              ),
                              icon: Icon(
                                color: ColorTheme.tWhiteColor,
                                Icons.arrow_right_alt_rounded,
                              ),
                              onPressed: () {
                                context.read<AdminBloc>().add(
                                      AdminTypeChanged(
                                        adminType: AdminType.words,
                                        lesson: lesson,
                                        level: state.level,
                                      ),
                                    );
                              },
                            ),
                          ],
                        ),
                        Center(
                          child: Text(lesson.label),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
