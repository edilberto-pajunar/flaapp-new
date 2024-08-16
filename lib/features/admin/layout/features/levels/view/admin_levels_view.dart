import 'package:flaapp/features/admin/layout/bloc/admin_bloc.dart';
import 'package:flaapp/features/admin/layout/features/lessons/view/admin_lessons_page.dart';
import 'package:flaapp/features/admin/layout/widget/drawer.dart';
import 'package:flaapp/utils/constant/theme/colors.dart';
import 'package:flaapp/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';

class AdminLevelsView extends StatefulWidget {
  const AdminLevelsView({
    super.key,
  });

  @override
  State<AdminLevelsView> createState() => _AdminLevelsViewState();
}

class _AdminLevelsViewState extends State<AdminLevelsView> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AdminBloc, AdminState>(
        bloc: context.read<AdminBloc>(),
        listenWhen: (prev, curr) => prev.adminStatus != curr.adminStatus,
        listener: (context, state) {
          if (state.adminStatus == AdminStatus.loading) {
            context.pop();
          }
        },
        builder: (context, state) {
          return Row(
            children: [
              const AdminDrawer(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("LEVELS"),
                          PrimaryButton(
                            label: "Add a level",
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: const Text("Add a level"),
                                    content: FormBuilder(
                                      key: _formKey,
                                      onChanged: () =>
                                          _formKey.currentState!.save(),
                                      child: FormBuilderTextField(
                                        name: "level",
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
                                            context.read<AdminBloc>().add(
                                                  AdminAddLevelSubmitted(
                                                    level: _formKey
                                                        .currentState!
                                                        .value["level"],
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
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ColorTheme.tBlackColor.withOpacity(0.1),
                        ),
                        child: DataTable(
                          border: TableBorder.all(),
                          columns: const [
                            DataColumn(
                              label: Text("Levels"),
                            ),
                            DataColumn(
                              label: Text(""),
                            ),
                          ],
                          rows: state.levels.map((level) {
                            return DataRow(
                              cells: [
                                DataCell(
                                  SizedBox(
                                    width: double.infinity,
                                    child: TextFormField(
                                      initialValue: level.label,
                                      onChanged: (val) {
                                        context
                                            .read<AdminBloc>()
                                            .add(AdminLevelChanged(
                                              level.copyWith(label: val),
                                            ));
                                      },
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        style: IconButton.styleFrom(
                                          backgroundColor:
                                              ColorTheme.tBlueColor,
                                        ),
                                        icon: Icon(
                                          color: ColorTheme.tWhiteColor,
                                          Icons.arrow_right_alt_rounded,
                                        ),
                                        onPressed: () {
                                          // context.read<AdminBloc>().add(
                                          //       AdminTypeChanged(
                                          //         adminType: AdminType.lessons,
                                          //         level: level,
                                          //       ),
                                          //     );
                                          context.goNamed(
                                              AdminLessonsPage.route,
                                              pathParameters: {
                                                "level_id": level.id.toString(),
                                              });
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
                      const SizedBox(height: 12.0),
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
