import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/services/functions/nav.dart';
import 'package:flaapp/services/networks/admin.dart';
import 'package:flaapp/services/networks/auth.dart';
import 'package:flaapp/views/screens/admin/add_word_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Admin admin = Provider.of<Admin>(context);
    final NavigationServices nav = NavigationServices();
    final Auth auth = Provider.of<Auth>(context);

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Admin"),
          automaticallyImplyLeading: false,
          actions: [
            TextButton.icon(
              label: const Text("Sign out"),
              onPressed: () {
                auth.logout();
              },
              icon: const Icon(
                Icons.logout,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Choose a level:"),
                SizedBox(
                  child: DropdownButton<String>(
                    items: Admin.levelList.map((level) {
                      return DropdownMenuItem(
                        value: level,
                        child: Text(level),
                      );
                    }).toList(),
                    onChanged: admin.updateLevel,
                    value: admin.level,
                  ),
                ),
                const SizedBox(height: 50.0),
                const Text("Choose a lesson:"),
                SizedBox(
                  child: DropdownButton<String>(
                    items: Admin.lessonList[Admin.levelList.indexOf(admin.level ?? "A1")].map((lesson) {
                      return DropdownMenuItem(
                        value: lesson,
                        child: Text(lesson),
                      );
                    }).toList(),
                    onChanged: admin.updateLesson,
                    value: admin.lesson,
                  ),
                ),
                const SizedBox(height: 50.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text("List of Words from ${admin.level}-${admin.lesson}"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        nav.pushScreen(context, screen: const AddWordScreen());
                      },
                      child: const Text("Add a word"),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                const _WordList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WordList extends StatelessWidget {
  const _WordList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final Admin admin = Provider.of<Admin>(context);

    return SizedBox(
      width: size.width * 0.7,
      child: FutureBuilder<LessonModel>(
        future: admin.getWordList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: data.words.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(data.words[index].word),
                        const Text("EN"),
                      ],
                    ),
                    ...data.words[index].translations.map((translation) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(translation),
                          ),
                          if (data.words[index].translations.indexOf(translation) == 0) const Text("DE"),
                          if (data.words[index].translations.indexOf(translation) == 1) const Text("ES"),
                          if (data.words[index].translations.indexOf(translation) == 2) const Text("PH"),
                        ],
                      );
                    }).toList(),
                  ]),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong."),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
