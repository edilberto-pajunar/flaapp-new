import 'dart:math';

import 'package:flaapp/features/language/bloc/language_bloc.dart';
import 'package:flaapp/model/language.dart';
import 'package:flaapp/widgets/buttons/primary_button.dart';
import 'package:flaapp/widgets/fields/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';

class AddAdminLanguageView extends StatefulWidget {
  const AddAdminLanguageView({super.key});

  @override
  State<AddAdminLanguageView> createState() => _AddAdminLanguageViewState();
}

class _AddAdminLanguageViewState extends State<AddAdminLanguageView> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Language"),
      ),
      body: BlocConsumer<LanguageBloc, LanguageState>(
        listenWhen: (prev, curr) => prev.status != curr.status,
        listener: (context, state) {
          if (state.status == LanguageStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Language added successfully"),
              ),
            );
            context.pop();
          } else if (state.status == LanguageStatus.failed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Error: ${state.error}"),
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: FormBuilder(
                key: _formKey,
                onChanged: () => _formKey.currentState?.save(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    PrimaryTextField(
                      label: "Language",
                      name: "language",
                      hintText: "English",
                      required: true,
                    ),
                    PrimaryTextField(
                      label: "Code",
                      name: "code",
                      hintText: "en",
                      required: true,
                    ),
                    PrimaryTextField(
                      label: "Flag",
                      name: "flag",
                      hintText: "https://flagcdn.com/us.svg",
                      required: true,
                    ),
                    const SizedBox(height: 12.0),
                    PrimaryButton(
                      label: "Save Language",
                      onTap: () {
                        if (_formKey.currentState!.saveAndValidate()) {
                          final value = _formKey.currentState?.value ?? {};

                          context.read<LanguageBloc>().add(LanguageAddRequested(
                                language: LanguageModel(
                                  language: value["language"],
                                  code: value["code"],
                                  flag: value["flag"],
                                ),
                              ));
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
