import 'package:flaapp/features/admin/layout/bloc/admin_bloc.dart';
import 'package:flaapp/features/admin/layout/features/words/view/admin_words_page.dart';
import 'package:flaapp/features/admin/layout/widget/drawer.dart';
import 'package:flaapp/model/level.dart';
import 'package:flaapp/utils/constant/theme/colors.dart';
import 'package:flaapp/widgets/buttons/primary_button.dart';
import 'package:flaapp/widgets/tiles/not_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';

class AdminLessonsView extends StatefulWidget {
  const AdminLessonsView({
    required this.levelModel,
    super.key,
  });

  final LevelModel levelModel;

  @override
  State<AdminLessonsView> createState() => _AdminLessonsViewState();
}

class _AdminLessonsViewState extends State<AdminLessonsView> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

          return Row(
            children: [
              const AdminDrawer(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
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
                                    title: const Text("Add a lesson"),
                                    content: FormBuilder(
                                      key: _formKey,
                                      onChanged: () =>
                                          _formKey.currentState!.save(),
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
                                          if (_formKey.currentState!
                                              .validate()) {
                                            context
                                              ..read<AdminBloc>().add(
                                                AdminAddLessonSubmitted(
                                                  lesson: _formKey.currentState!
                                                      .value["lesson"],
                                                  level: widget.levelModel,
                                                ),
                                              )
                                              ..pop();
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
                      state.lessons.isEmpty
                          ? const Expanded(
                              child: NotFound(
                                label: "No Lessons",
                              ),
                            )
                          : Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color:
                                        ColorTheme.tBlackColor.withOpacity(0.1),
                                  ),
                                  child: DataTable(
                                    border: TableBorder.all(),
                                    columns: const [
                                      DataColumn(
                                        label: Text("Lessons"),
                                      ),
                                      DataColumn(
                                        label: Text(""),
                                      ),
                                    ],
                                    rows: state.lessons.map((lesson) {
                                      return DataRow(
                                        cells: [
                                          DataCell(
                                            SizedBox(
                                              width: double.infinity,
                                              child: TextFormField(
                                                initialValue: lesson.label,
                                                onChanged: (val) {
                                                  context.read<AdminBloc>().add(
                                                        AdminLessonChanged(
                                                            lesson.copyWith(
                                                                label: val)),
                                                      );
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                IconButton(
                                                  style: IconButton.styleFrom(
                                                    backgroundColor:
                                                        ColorTheme.tBlueColor,
                                                  ),
                                                  icon: Icon(
                                                    color:
                                                        ColorTheme.tWhiteColor,
                                                    Icons
                                                        .arrow_right_alt_rounded,
                                                  ),
                                                  onPressed: () {
                                                    // context.read<AdminBloc>().add(
                                                    //       AdminTypeChanged(
                                                    //         adminType: AdminType.lessons,
                                                    //         lesson: level,
                                                    //       ),
                                                    //     );
                                                    context.goNamed(
                                                      AdminWordsPage.route,
                                                      pathParameters: {
                                                        "level_id": widget
                                                            .levelModel.id,
                                                        "lesson_id": lesson.id
                                                            .toString(),
                                                      },
                                                      extra: {
                                                        "lessonModel": lesson,
                                                        "levelModel":
                                                            widget.levelModel,
                                                      },
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
