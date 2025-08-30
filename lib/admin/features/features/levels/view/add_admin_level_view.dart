import 'package:flaapp/admin/features/bloc/admin_bloc.dart';
import 'package:flaapp/widgets/buttons/primary_button.dart';
import 'package:flaapp/widgets/fields/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';

class AddAdminLevelView extends StatefulWidget {
  const AddAdminLevelView({
    super.key,
  });

  @override
  State<AddAdminLevelView> createState() => _AddAdminLevelViewState();
}

class _AddAdminLevelViewState extends State<AddAdminLevelView> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Level"),
      ),
      body: BlocConsumer<AdminBloc, AdminState>(
        listenWhen: (prev, curr) => prev.adminStatus != curr.adminStatus,
        listener: (context, state) {
          if (state.adminStatus == AdminStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Level added successfully"),
              ),
            );
            context.pop();
          } else if (state.adminStatus == AdminStatus.failed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Error: ${state.error}"),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.adminStatus == AdminStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: FormBuilder(
                key: _formKey,
                onChanged: () => _formKey.currentState?.save(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("Level"),
                    PrimaryTextField(
                      label: "Title",
                      name: "level",
                      required: true,
                    ),
                    const SizedBox(height: 12.0),
                    PrimaryTextField(
                      label: "Description",
                      name: "description",
                      required: true,
                    ),
                    PrimaryButton(
                      label: "Add Level",
                      onTap: () {
                        if (_formKey.currentState!.saveAndValidate()) {
                          final value = _formKey.currentState?.value ?? {};
                          context.read<AdminBloc>().add(AdminAddLevelSubmitted(
                                level: value["level"],
                                description: value["description"],
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
