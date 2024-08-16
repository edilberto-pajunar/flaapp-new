import 'package:flaapp/features/admin/layout/bloc/admin_bloc.dart';
import 'package:flaapp/features/admin/layout/widget/drawer.dart';
import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/model/level.dart';
import 'package:flaapp/utils/constant/theme/colors.dart';
import 'package:flaapp/widgets/buttons/primary_button.dart';
import 'package:flaapp/widgets/tiles/not_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';

class AdminWordsView extends StatefulWidget {
  const AdminWordsView({
    required this.levelModel,
    required this.lessonModel,
    super.key,
  });

  final LevelModel levelModel;
  final LessonModel lessonModel;

  @override
  State<AdminWordsView> createState() => _AdminWordsViewState();
}

class _AdminWordsViewState extends State<AdminWordsView> {
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
                          const Text("WORDS"),
                          PrimaryButton(
                            label: "Add a word",
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: const Text("Add a word"),
                                    content: FormBuilder(
                                      key: _formKey,
                                      onChanged: () =>
                                          _formKey.currentState!.save(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          FormBuilderTextField(
                                            name: "us",
                                            validator: (val) {
                                              if (val == null || val.isEmpty) {
                                                return "This field is required";
                                              }
                                              return null;
                                            },
                                            decoration: const InputDecoration(
                                              hintText: "English Word",
                                            ),
                                          ),
                                          FormBuilderTextField(
                                            name: "de",
                                            validator: (val) {
                                              if (val == null || val.isEmpty) {
                                                return "This field is required";
                                              }
                                              return null;
                                            },
                                            decoration: const InputDecoration(
                                              hintText: "German Word",
                                            ),
                                          ),
                                          FormBuilderTextField(
                                            name: "es",
                                            validator: (val) {
                                              if (val == null || val.isEmpty) {
                                                return "This field is required";
                                              }
                                              return null;
                                            },
                                            decoration: const InputDecoration(
                                              hintText: "Spanish Word",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      PrimaryButton(
                                        label: "Add",
                                        onTap: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            final word =
                                                _formKey.currentState?.value;

                                            context
                                              ..read<AdminBloc>().add(
                                                AdminAddWordSubmitted(
                                                  level: widget.levelModel,
                                                  lesson: widget.lessonModel,
                                                  us: word!["us"],
                                                  de: word["de"],
                                                  es: word["es"],
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
                      state.words.isEmpty
                          ? const NotFound(label: "No Words")
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
                                        label: Text("English"),
                                      ),
                                      DataColumn(
                                        label: Text("German"),
                                      ),
                                      DataColumn(
                                        label: Text("Spanish"),
                                      ),
                                    ],
                                    rows: state.words.map((word) {
                                      return DataRow(
                                        cells: word.translations
                                            .map((translation) {
                                          return DataCell(
                                            SizedBox(
                                              width: double.infinity,
                                              child: TextFormField(
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                ),
                                                initialValue: translation.word,
                                                onChanged: (val) {
                                                  final index = word
                                                      .translations
                                                      .indexOf(translation);
                                                  context
                                                      .read<AdminBloc>()
                                                      .add(AdminWordChanged(
                                                        word: word,
                                                        updatedWord: val,
                                                        index: index,
                                                      ));
                                                },
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        // cells: [
                                        //   DataCell(
                                        //     SizedBox(
                                        //       width: double.infinity,
                                        //       child: TextFormField(
                                        //         decoration: const InputDecoration(
                                        //           border: InputBorder.none,
                                        //         ),
                                        //         initialValue:
                                        //             word.translations[0].word,
                                        //         onChanged: (val) {
                                        //         },
                                        //       ),
                                        //     ),
                                        //   ),
                                        //   DataCell(
                                        //     SizedBox(
                                        //       width: double.infinity,
                                        //       child: TextFormField(
                                        //         decoration: const InputDecoration(
                                        //           border: InputBorder.none,
                                        //         ),
                                        //         initialValue:
                                        //             word.translations[1].word,
                                        //         onChanged: (val) {},
                                        //       ),
                                        //     ),
                                        //   ),
                                        //   DataCell(
                                        //     SizedBox(
                                        //       width: double.infinity,
                                        //       child: TextFormField(
                                        //         decoration: const InputDecoration(
                                        //           border: InputBorder.none,
                                        //         ),
                                        //         initialValue:
                                        //             word.translations[2].word,
                                        //         onChanged: (val) {},
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ],
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
