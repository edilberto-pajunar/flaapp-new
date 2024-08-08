import 'package:flaapp/features/admin/layout/bloc/admin_bloc.dart';
import 'package:flaapp/features/admin/layout/widget/word_list.dart';
import 'package:flaapp/model/word.dart';
import 'package:flaapp/values/constant/theme/colors.dart';
import 'package:flaapp/views/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';

class AdminWords extends StatefulWidget {
  const AdminWords({super.key});

  @override
  State<AdminWords> createState() => _AdminWordsState();
}

class _AdminWordsState extends State<AdminWords> {
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
                const Text("WORDS"),
                PrimaryButton(
                  label: "Add a word",
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: const Text("Add a level"),
                          content: FormBuilder(
                            key: _formKey,
                            onChanged: () => _formKey.currentState!.save(),
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
                                if (_formKey.currentState!.validate()) {
                                  final word = _formKey.currentState?.value;

                                  context.read<AdminBloc>().add(
                                        AdminAddWordSubmitted(
                                          level: state.level!,
                                          lesson: state.lesson!,
                                          us: word!["us"],
                                          de: word["de"],
                                          es: word["es"],
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
              child: ListView.builder(
                itemCount: state.words.length,
                itemBuilder: (context, index) {
                  final word = state.words[index];
                  return Container(
                    padding: const EdgeInsets.all(12.0),
                    color: Colors.grey.shade300,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(word.word),
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
                                                .add(AdminDeleteWordRequested(
                                                  word.id,
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
                          ],
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
