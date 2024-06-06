// import 'package:flaapp/features/admin/bloc/admin_bloc.dart';
// import 'package:flaapp/bloc/translate/translate_bloc.dart';
// import 'package:flaapp/model/word.dart';
// import 'package:flaapp/repository/database/database_repository.dart';
// import 'package:flaapp/views/widgets/fields/primary_text_field.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class AddWordScreen extends StatefulWidget {
//   const AddWordScreen({
//     required this.state,
//     super.key,
//   });

//   final AdminLoaded state;

//   @override
//   State<AddWordScreen> createState() => _AddWordScreenState();
// }

// class _AddWordScreenState extends State<AddWordScreen> {
//   final TextEditingController word = TextEditingController();

//   @override
//   void dispose() {
//     super.dispose();
//     word.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Add a word"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(AppLocalizations.of(context)!.chooseALevel),
//               SizedBox(
//                 child: DropdownButton<String>(
//                   items: widget.state.levelList.map((level) {
//                     return DropdownMenuItem(
//                       value: level.label,
//                       child: Text(level.label),
//                     );
//                   }).toList(),
//                   onChanged: (val) {
//                     context.read<AdminBloc>().add(UpdateLevel(level: val!));
//                   },
//                   value: widget.state.level,
//                 ),
//               ),
//               Text(AppLocalizations.of(context)!.chooseALesson),

//               SizedBox(
//                 child: DropdownButton<String>(
//                   items: widget.state.lessonList?.map((lesson) {
//                     return DropdownMenuItem(
//                       value: lesson.label,
//                       child: Text(lesson.label),
//                     );
//                   }).toList(),
//                   onChanged: (val) {
//                     context.read<AdminBloc>().add(UpdateLesson(lesson: val!));
//                   },
//                   value: widget.state.lesson,
//                 ),
//               ),
//               // const Text("Translation Language:"),
//               // Row(
//               //   children: Admin.translationLangList.map((String lang) {
//               //     return RadioMenuButton(
//               //       groupValue: admin.translationLang,
//               //       onChanged: admin.updateTranslationLang,
//               //       value: lang,
//               //       child: Text(lang),
//               //     );
//               //   }).toList(),
//               // ),
//               PrimaryTextField(
//                 controller: word,
//                 label: AppLocalizations.of(context)!.enterAWord,
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   context.read<TranslateBloc>().add(TranslateWord(word: word.text));
//                 },
//                 style: ElevatedButton.styleFrom(
//                   fixedSize: Size.fromWidth(size.width * 0.9),
//                 ),
//                 child: Text(AppLocalizations.of(context)!.translate),
//               ),
//               const SizedBox(height: 20.0),
//               BlocBuilder<TranslateBloc, TranslateState>(
//                 builder: (context, state) {
//                   if (state is TranslateInitial) {
//                     return const Center(
//                       child: Text("Please input a word"),
//                     );
//                   }
//                   if (state is TranslateLoading) {
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }

//                   if (state is TranslateLoaded) {
//                     return Column(
//                       children: [
//                         state.isEdit
//                             ? TextFormField(
//                                 onChanged: (val) {
//                                   context.read<TranslateBloc>().add(UpdateEnglish(word: val));
//                                 },
//                                 decoration: const InputDecoration(
//                                   label: Text("English"),
//                                 ),
//                                 initialValue: state.translatedWordList[0],
//                               )
//                             : Text("English: ${state.translatedWordList[0]}"),
//                         state.isEdit
//                             ? TextFormField(
//                                 onChanged: (val) {
//                                   context.read<TranslateBloc>().add(UpdateGerman(word: val));
//                                 },
//                                 decoration: const InputDecoration(
//                                   label: Text("German"),
//                                 ),
//                                 initialValue: state.translatedWordList[2],
//                               )
//                             : Text("German: ${state.translatedWordList[2]}"),
//                         state.isEdit
//                             ? TextFormField(
//                                 onChanged: (val) {
//                                   context.read<TranslateBloc>().add(UpdateSpanish(word: val));
//                                 },
//                                 decoration: const InputDecoration(
//                                   label: Text("Spanish"),
//                                 ),
//                                 initialValue: state.translatedWordList[1],
//                               )
//                             : Text("Spanish: ${state.translatedWordList[1]}"),
//                         const SizedBox(height: 20.0),
//                         ElevatedButton(
//                           onPressed: () {
//                             context.read<TranslateBloc>().add(EditWord(isEdit: !state.isEdit));
//                           },
//                           style: ElevatedButton.styleFrom(
//                             fixedSize: Size.fromWidth(size.width * 0.9),
//                           ),
//                           child: Text(!state.isEdit ? "Edit" : AppLocalizations.of(context)!.save),
//                         ),
//                         ElevatedButton(
//                           onPressed: () async {
//                             final WordModel updatedWord = WordModel(
//                               level: widget.state.level!,
//                               lesson: widget.state.lesson!,
//                               word: word.text,
//                               translations: state.translatedWordList,
//                               updateTime: DateTime.now(),
//                               id: word.text,
//                             );
//                             await context.read<DatabaseRepository>().addWord(updatedWord);
//                           },
//                           style: ElevatedButton.styleFrom(
//                             fixedSize: Size.fromWidth(size.width * 0.9),
//                           ),
//                           child: Text(AppLocalizations.of(context)!.addToTheList),
//                         ),
//                       ],
//                     );
//                   } else {
//                     return const Center(
//                       child: Text("Something went wrong."),
//                     );
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
