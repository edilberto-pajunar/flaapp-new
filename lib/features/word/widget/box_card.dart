import 'package:flaapp/features/word/bloc/word_bloc.dart';
import 'package:flaapp/values/constant/strings/image.dart';
import 'package:flaapp/values/constant/theme/colors.dart';
import 'package:flutter/material.dart';

class BoxCard extends StatelessWidget {
  const BoxCard({
    super.key,
    required this.state,
  });

  final WordState state;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.13,
      child: ListView.builder(
        itemCount: 5,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final currentWords =
              state.words.where((element) => element.box == index);

          return SizedBox(
            width: size.width * 0.19,
            child: Stack(
              children: [
                Positioned(
                  top: 12,
                  child: InkWell(
                    // onTap: currentWords.isEmpty ||
                    //         currentWords.length != nextWords.length
                    //     ? null
                    //     : () => context
                    //         .read<WordBloc>()
                    //         .add(WordBoxTapped(boxIndex: index)),
                    child: Container(
                      height: 80,
                      width: size.width * 0.17,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: ColorTheme.tTertiaryBlueColor,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 4),
                            blurRadius: 4.0,
                            color: Colors.black.withOpacity(0.25),
                          ),
                        ],
                        border: state.boxIndex == index
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
                    visible: state.lockedTime != null &&
                        index == state.words.last.box,
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
