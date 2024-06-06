import 'package:flaapp/views/widgets/buttons/primary_button.dart';
import 'package:flaapp/views/widgets/fields/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddLevel extends StatefulWidget {
  const AddLevel({super.key});

  @override
  State<AddLevel> createState() => _AddLevelState();
}

class _AddLevelState extends State<AddLevel> {
  final TextEditingController level = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text("Add a level"),
      trailing: const Icon(Icons.arrow_forward),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Add a Level"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PrimaryTextField(
                    label: "Level",
                    controller: level,
                  ),
                ],
              ),
              actions: [
                PrimaryButton(
                  label: "Add",
                  onTap: () {
                  },
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
