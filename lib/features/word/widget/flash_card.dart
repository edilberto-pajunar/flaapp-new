import 'package:flaapp/features/word/bloc/card_bloc.dart';
import 'package:flaapp/features/word/bloc/word_bloc.dart';
import 'package:flaapp/model/word.dart';
import 'package:flaapp/utils/constant/strings/image.dart';
import 'package:flaapp/utils/constant/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class FlashCard extends StatelessWidget {
  const FlashCard({
    super.key,
    required this.word,
    required this.wordState,
    required this.cardState,
    required this.codeToLearn,
  });

  final WordModel word;
  final WordState wordState;
  final CardState cardState;
  final String codeToLearn;

  Color backgroundColor(WordState state) {
    if (cardState.direction == CardSwiperDirection.left) {
      return ColorTheme.tRedColor;
    } else if (cardState.direction == CardSwiperDirection.right) {
      return ColorTheme.tGreenColor;
    }
    return ColorTheme.tBlueColor;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    final translatedWord = word.translations
        ?.firstWhere(
          (translation) => translation.code == codeToLearn,
        )
        .word;

    return GestureDetector(
      onTap: () {
        context.read<CardBloc>().add(CardFlipped());
      },
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor(wordState),
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
                alignment: cardState.direction == CardSwiperDirection.right
                    ? Alignment.topRight
                    : Alignment.topLeft,
                child: Text(
                  cardState.direction == CardSwiperDirection.right
                      ? "Great!"
                      : cardState.direction == CardSwiperDirection.left
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
                  cardState.isFront ? word.word ?? "" : translatedWord ?? "",
                  style: theme.textTheme.headlineLarge!.copyWith(
                    color: ColorTheme.tWhiteColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: ColorTheme.tRedColor,
                      child: IconButton(
                        onPressed: () {
                          context.read<WordBloc>().add(WordFavoriteAdded(
                                word: word,
                              ));
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: ColorTheme.tBlackColor,
                      child: IconButton(
                        onPressed: () async {
                          context.read<WordBloc>().add(WordSpeakRequested(
                                frontWord: word.word ?? "",
                                backWord: translatedWord ?? "",
                              ));
                        },
                        iconSize: 20.0,
                        icon: const Icon(
                          Icons.volume_down,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: cardState.isFront,
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
  }
}
