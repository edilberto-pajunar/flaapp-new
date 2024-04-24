import 'package:flaapp/services/networks/admin.dart';
import 'package:flaapp/views/widgets/buttons/primary_button.dart';
import 'package:flaapp/views/widgets/fields/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddWordScreen extends StatelessWidget {
  const AddWordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController word = TextEditingController();
    final Admin admin = Provider.of<Admin>(context);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a word"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
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
              const Text("Translation Language:"),
              Row(
                children: Admin.translationLangList.map((String lang) {
                  return RadioMenuButton(
                    groupValue: admin.translationLang,
                    onChanged: admin.updateTranslationLang,
                    value: lang,
                    child: Text(lang),
                  );
                }).toList(),
              ),
              PrimaryTextField(
                controller: word,
                label: "Enter a word",
              ),
              ElevatedButton(
                onPressed: () async {
                  await admin.updateTranslateWord(
                    word.text,
                    "EN",
                  );
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromWidth(size.width * 0.9),
                ),
                child: const Text("Translate"),
              ),
              const SizedBox(height: 20.0),
              admin.isEdit
                  ? TextFormField(
                      onChanged: admin.updateEnWordChange,
                      decoration: const InputDecoration(
                        label: Text("English"),
                      ),
                      initialValue: admin.enWord,
                    )
                  : Text("English: ${admin.enWord}"),
              admin.isEdit
                  ? TextFormField(
                      onChanged: admin.updateEsWordChange,
                      decoration: const InputDecoration(
                        label: Text("Spanish"),
                      ),
                      initialValue: admin.esWord,
                    )
                  : Text("Spanish: ${admin.esWord}"),
              admin.isEdit
                  ? TextFormField(
                      onChanged: admin.updateDeWordChange,
                      decoration: const InputDecoration(
                        label: Text("German"),
                      ),
                      initialValue: admin.deWord,
                    )
                  : Text("German: ${admin.deWord}"),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  admin.updateIsEdit();
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromWidth(size.width * 0.9),
                ),
                child: Text(!admin.isEdit ? "Edit" : "Save"),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromWidth(size.width * 0.9),
                ),
                child: const Text("Add to the List"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}