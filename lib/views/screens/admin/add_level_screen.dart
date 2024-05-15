import 'package:flaapp/model/level.dart';
import 'package:flaapp/repository/database/database_repository.dart';
import 'package:flaapp/views/widgets/buttons/primary_button.dart';
import 'package:flaapp/views/widgets/fields/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddLevelScreen extends StatelessWidget {
  const AddLevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController level = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Level"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              PrimaryTextField(
                label: "Level",
                controller: level,
              ),
              const SizedBox(height: 12.0),
              PrimaryButton(
                label: "Save",
                onTap: () {
                  final LevelModel newLevel = LevelModel(
                    label: level.text,
                    id: level.text,
                  );
                  context.read<DatabaseRepository>().addLevel(newLevel);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
