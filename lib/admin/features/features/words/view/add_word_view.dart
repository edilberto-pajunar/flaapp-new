import 'package:flaapp/admin/features/bloc/admin_bloc.dart';
import 'package:flaapp/model/translation.dart';
import 'package:flaapp/model/word.dart';
import 'package:flaapp/widgets/buttons/primary_button.dart';
import 'package:flaapp/widgets/fields/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';

class AdminAddWordView extends StatefulWidget {
  const AdminAddWordView({
    super.key,
    required this.levelId,
    required this.lessonId,
  });

  final String levelId;
  final String lessonId;

  @override
  State<AdminAddWordView> createState() => _AdminAddWordViewState();
}

class _AdminAddWordViewState extends State<AdminAddWordView> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Word"),
      ),
      body: BlocConsumer<AdminBloc, AdminState>(
        listenWhen: (prev, curr) => prev.adminStatus != curr.adminStatus,
        listener: (context, state) {
          if (state.adminStatus == AdminStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Word added successfully"),
              ),
            );
            context.pop();
          }
          if (state.adminStatus == AdminStatus.failed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Error: ${state.error}"),
              ),
            );
          }
        },
        builder: (context, state) {
          return state.adminStatus == AdminStatus.loading
              ? const Center(child: CircularProgressIndicator())
              : FormBuilder(
                  key: _formKey,
                  onChanged: () => _formKey.currentState?.save(),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        PrimaryTextField(
                          label: "Word",
                          name: "word",
                          required: true,
                        ),
                        ListView.builder(
                          itemCount: state.languages.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final language = state.languages[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(language.language ?? ""),
                                PrimaryTextField(
                                  name: language.language ?? "",
                                  hintText: "${language.language ?? ""} Word",
                                  required: true,
                                ),
                              ],
                            );
                          },
                        ),
                        PrimaryButton(
                          label: "Save Word",
                          onTap: () {
                            if (_formKey.currentState!.saveAndValidate()) {
                              final value = _formKey.currentState?.value ?? {};
                              final WordModel wordModel = WordModel(
                                lessonId: widget.lessonId,
                                levelId: widget.lessonId,
                                word: value["word"],
                                translations: state.languages.map((lang) {
                                  return Translation(
                                    word: value[lang.language ?? ""],
                                    language: lang.language ?? "",
                                    code: lang.code ?? "",
                                  );
                                }).toList(),
                              );
                              context
                                  .read<AdminBloc>()
                                  .add(AdminAddWordSubmitted(
                                    word: wordModel,
                                    levelId: widget.levelId,
                                    lessonId: widget.lessonId,
                                  ));
                            }
                          },
                        ),
                        const SizedBox(height: 24.0),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
