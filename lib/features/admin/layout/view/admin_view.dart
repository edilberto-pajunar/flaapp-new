import 'package:flaapp/features/admin/layout/features/levels/view/admin_levels_page.dart';
import 'package:flutter/material.dart';

class AdminView extends StatefulWidget {
  const AdminView({super.key});

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  final TextEditingController lesson = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Widget buildMain(AdminState state) {
    //   switch (state.adminType) {
    //     case AdminType.levels:
    //       return const AdminLevels();
    //     case AdminType.lessons:
    //       return const AdminLessons();
    //     case AdminType.words:
    //       return const AdminWords();
    //     default:
    //       return const AdminLevels();
    //   }
    // }

    return const AdminLevelsPage();

    // return SafeArea(
    //   child: Scaffold(
    //     backgroundColor: theme.colorScheme.surface,
    //     body: BlocBuilder<AdminBloc, AdminState>(
    //       builder: (context, state) {
    //         if (state.adminStatus == AdminStatus.loading) {
    //           return const Center(
    //             child: CircularProgressIndicator(),
    //           );
    //         }
    //         return Row(
    //           children: [
    //             Container(
    //               width: 240,
    //               decoration: const BoxDecoration(
    //                 color: Color(0xFFF3F4F6),
    //                 border: Border(
    //                   right: BorderSide(
    //                     width: 2.0,
    //                   ),
    //                 ),
    //               ),
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   const Center(
    //                     child: DrawerHeader(
    //                       child: Text("Admin"),
    //                     ),
    //                   ),
    //                   const Divider(),
    //                   ListTile(
    //                     onTap: () => context
    //                         .read<AdminBloc>()
    //                         .add(const AdminTypeChanged(
    //                           adminType: AdminType.levels,
    //                         )),
    //                     title: const Text("Levels"),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             Expanded(
    //               child: Padding(
    //                 padding: const EdgeInsets.all(24.0),
    //                 child: buildMain(state),
    //               ),
    //             ),
    //           ],
    //         );
    //       },
    //     ),
    //   ),
    // );

    // return PopScope(
    //   canPop: false,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: const Text("Admin"),
    //       automaticallyImplyLeading: false,
    //       actions: [
    //         TextButton.icon(
    //           label: const Text("Choose language"),
    //           onPressed: () {},
    //           icon: const Icon(
    //             Icons.language,
    //           ),
    //         ),
    //         IconButton(
    //           onPressed: () {
    //             context.read<AuthBloc>().add(AuthSignOutAttempted());
    //           },
    //           icon: const Icon(
    //             Icons.logout,
    //           ),
    //         ),
    //       ],
    //     ),
    //     body: BlocBuilder<AdminBloc, AdminState>(
    //       builder: (context, state) {
    //         return SingleChildScrollView(
    //           child: Padding(
    //             padding: const EdgeInsets.all(20.0),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text("${AppLocalizations.of(context)!.chooseALevel}:"),
    //                 DropdownButton<String>(
    //                   items: state.levels.map((level) {
    //                     return DropdownMenuItem(
    //                       value: level.label,
    //                       child: Text(level.label),
    //                     );
    //                   }).toList(),
    //                   onChanged: (val) {
    //                     context
    //                         .read<AdminBloc>()
    //                         .add(AdminLessonStreamRequested(level: val!));
    //                   },
    //                   value: state.level,
    //                 ),
    //                 Text("${AppLocalizations.of(context)!.chooseALesson}:"),
    //                 DropdownButton<String>(
    //                   items: state.lessons.map((lesson) {
    //                     return DropdownMenuItem(
    //                       value: lesson.label,
    //                       child: Text(lesson.label),
    //                     );
    //                   }).toList(),
    //                   onChanged: (val) {
    //                     context
    //                         .read<AdminBloc>()
    //                         .add(AdminWordStreamRequested(lesson: val!));
    //                   },
    //                   value: state.lesson,
    //                 ),
    //                 const AddLevel(),
    //                 const Divider(),
    //                 const AddLesson(),
    //                 const Divider(),
    //                 const AddWord(),
    //                 const Divider(),
    //                 const SizedBox(height: 24.0),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Expanded(
    //                       child: Text(
    //                         "List of Words from ${state.level ?? ""}-${state.lesson ?? ""}",
    //                         style: theme.textTheme.bodyLarge!.copyWith(
    //                           fontWeight: FontWeight.bold,
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //                 const SizedBox(height: 12.0),
    //                 WordList(
    //                   state: state,
    //                 ),
    //               ],
    //             ),
    //           ),
    //         );
    //       },
    //     ),
    //   ),
    // );
  }
}
