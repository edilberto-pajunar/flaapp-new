import 'package:flaapp/features/admin/bloc/admin_bloc.dart';
import 'package:flutter/material.dart';

class WordList extends StatelessWidget {
  const WordList({
    super.key,
    required this.state,
  });

  final AdminState state;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width * 0.7,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: state.words.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              children: state.words[index].translations.map((translation) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(translation),
                    ),
                    if (state.words[index].translations.indexOf(translation) ==
                        0)
                      const Text("German"),
                    if (state.words[index].translations.indexOf(translation) ==
                        1)
                      const Text("English"),
                    if (state.words[index].translations.indexOf(translation) ==
                        2)
                      const Text("Spanish"),
                  ],
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
