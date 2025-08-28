import 'package:flaapp/features/word/bloc/card_bloc.dart';
import 'package:flaapp/features/word/bloc/word_bloc.dart';
import 'package:flaapp/utils/constant/strings/image.dart';
import 'package:flaapp/utils/constant/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProgressCard extends StatelessWidget {
  const ProgressCard({
    super.key,
    required this.state,
    required this.cardState,
  });

  final WordState state;
  final CardState cardState;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SizedBox(
      height: 100,
      child: ListView.separated(
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 12.0),
        itemBuilder: (context, index) {
          final currentWords =
              state.userWords.where((element) => element.box == index).toList();

          return SizedBox(
            width: 70.0,
            child: Stack(
              children: [
                Positioned(
                  top: 12,
                  child: InkWell(
                    onTap: () {
                      if (currentWords.isEmpty) return;
                      context.read<CardBloc>().add(CardProgressIndexChanged(
                            currentBox: index,
                          ));
                    },
                    child: Container(
                      height: 80,
                      width: 70.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: ColorTheme.tTertiaryBlueColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 4),
                            blurRadius: 4.0,
                            color: Colors.black.withValues(alpha: 0.25),
                          ),
                        ],
                        border: cardState.currentProgressIndex == index
                            ? Border.all(
                                color: ColorTheme.tBlueColor,
                                width: 2.0,
                              )
                            : null,
                      ),
                      child: Center(
                        child: currentWords.isEmpty
                            ? const Icon(Icons.lock)
                            : Stack(
                                children: [
                                  Center(
                                    child: index == state.boxIndex
                                        ? Image.asset(PngImage.card)
                                        : Image.asset(PngImage.cardDeactivated),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${currentWords.length}",
                                      style:
                                          theme.textTheme.bodyMedium!.copyWith(
                                        color: ColorTheme.tWhiteColor,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 28,
                  child: Visibility(
                    visible: index == state.words.last.box,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                        color: ColorTheme.tLightBlueColor,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Text(
                        "${state.lockedTime}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.2,
                          fontSize: 8.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
