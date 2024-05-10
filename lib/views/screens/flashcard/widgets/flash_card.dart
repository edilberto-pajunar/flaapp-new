import 'package:flaapp/bloc/word/word_bloc.dart';
import 'package:flaapp/model/word_new.dart';
import 'package:flaapp/values/constant/strings/image.dart';
import 'package:flaapp/values/constant/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class FlashCard extends StatelessWidget {
  const FlashCard({
    super.key,
    required this.wordModel,
    required this.state,
  });

  final WordNewModel wordModel;
  final WordLoaded state;

  Color get backgroundColor {
    if (state.duration != null) {
      return ColorTheme.tGreyColor;
    }
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
    final FlutterTts flutterTts = FlutterTts();

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
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
              alignment: state.position > 0 ? Alignment.topRight : Alignment.topLeft,
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
              child: state.duration != null
                  ? const Icon(Icons.lock)
                  : Text(
                      state.isFrontSide ? wordModel.word : wordModel.translations[0],
                      style: theme.textTheme.headlineLarge!.copyWith(
                        color: ColorTheme.tWhiteColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
            ),
          ),
          Visibility(
            visible: state.duration == null,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: ColorTheme.tBlackColor,
                  child: IconButton(
                    onPressed: () async {
                      // 16 : us
                      // 40 : de
                      // 46 : es
                      final List languages = await flutterTts.getLanguages;
                      await flutterTts.setLanguage(languages[46]);
                      await flutterTts.speak(
                        state.isFrontSide ? wordModel.word : wordModel.translations[0],
                      );
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
    );
  }
}