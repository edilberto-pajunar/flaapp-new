// import 'package:flaapp/features/admin/bloc/admin_bloc.dart';
// import 'package:flaapp/model/lesson.dart';
// import 'package:flaapp/repository/database/database_repository.dart';
// import 'package:flaapp/views/widgets/buttons/primary_button.dart';
// import 'package:flaapp/views/widgets/fields/primary_text_field.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class AddLessonScreen extends StatelessWidget {
//   const AddLessonScreen({
//     super.key,
//   });


//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController lesson = TextEditingController();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Add Lesson"),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(AppLocalizations.of(context)!.chooseALevel),
//               SizedBox(
//                 child: DropdownButton<String>(
//                   items: state.levelList.map((level) {
//                     return DropdownMenuItem(
//                       value: level.label,
//                       child: Text(level.label),
//                     );
//                   }).toList(),
//                   onChanged: (val) {
//                     context.read<AdminBloc>().add(UpdateLevel(level: val!));
//                   },
//                   value: state.level,
//                 ),
//               ),
//               const SizedBox(height: 12.0),
//               PrimaryTextField(
//                 label: "Lesson",
//                 controller: lesson,
//               ),
//               const SizedBox(height: 12.0),
//               Center(
//                 child: PrimaryButton(
//                   label: "Save",
//                   onTap: () {
//                     final LessonModel newLesson = LessonModel(
//                       label: lesson.text,
//                       level: state.level!,
//                       id: lesson.text,
//                     );

//                     if (lesson.text.isNotEmpty) {
//                       context.read<DatabaseRepository>().addLesson(newLesson);
//                     }
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
