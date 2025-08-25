import 'package:flaapp/features/word/bloc/word_bloc.dart';
import 'package:flaapp/model/word.dart';
import 'package:flaapp/utils/constant/strings/image.dart';
import 'package:flaapp/utils/constant/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlashCard extends StatelessWidget {
  const FlashCard({
    super.key,
    required this.word,
    required this.wordBloc,
  });

  final WordModel word;
  final WordBloc wordBloc;

  Color backgroundColor(WordState state) {
    if (state.position == 0) {
      return ColorTheme.tBlueColor;
    } else if (state.position > 200) {
      return ColorTheme.tGreenColor;
    } else {
      return ColorTheme.tRedColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;

    return BlocProvider.value(
      value: wordBloc,
      child: BlocConsumer<WordBloc, WordState>(
        listener: (context, state) {
          if (state.wordLoadingStatus == WordLoadingStatus.failed) {
            // Fluttertoast.showToast(msg: state.error);
          }
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              context.read<WordBloc>().add(WordFlipCardTapped());
            },
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor(state),
                borderRadius: BorderRadius.circular(24.0),
              ),
              height: size.height * 0.6,
              width: size.width * 0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 28.0,
                      top: 22.0,
                      right: 28.0,
                    ),
                    child: Align(
                      alignment: state.position > 0
                          ? Alignment.topRight
                          : Alignment.topLeft,
                      child: Text(
                        state.position > 0
                            ? "Great!"
                            : state.position < 0
                                ? "You got this. Let's try again!"
                                : "",
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        state.frontVisible
                            ? word.word
                            : word.translations[1].word,
                        style: theme.textTheme.headlineLarge!.copyWith(
                          color: ColorTheme.tWhiteColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    // visible: state.duration == null,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: ColorTheme.tBlackColor,
                          child: IconButton(
                            onPressed: () async {
                              context.read<WordBloc>().add(WordSpeakRequested(
                                    frontWord: word.word,
                                    backWord: word.translations[0].word,
                                  ));
                            },
                            iconSize: 30.0,
                            icon: const Icon(
                              Icons.volume_down,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 9.0),
                        decoration: BoxDecoration(
                          color: ColorTheme.tWhiteColor,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(23.0),
                            bottomRight: Radius.circular(23.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                "Click to flip the card",
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                            const SizedBox(width: 6.0),
                            Image.asset(PngImage.pointingUp),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
