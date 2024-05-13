import 'package:flaapp/bloc/auth/auth_bloc.dart';
import 'package:flaapp/bloc/word/word_bloc.dart';
import 'package:flaapp/model/lesson.dart';
import 'package:flaapp/repository/database/database_repository.dart';
import 'package:flaapp/repository/local/local_repository.dart';
import 'package:flaapp/services/functions/nav.dart';
import 'package:flaapp/values/constant/strings/image.dart';
import 'package:flaapp/values/constant/theme/colors.dart';
import 'package:flaapp/views/screens/flashcard/widgets/box_card.dart';
import 'package:flaapp/views/screens/flashcard/widgets/flash_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WordsScreen extends StatefulWidget {
  const WordsScreen({
    required this.level,
    required this.lesson,
    super.key,
  });

  final String level;
  final LessonModel lesson;

  @override
  State<WordsScreen> createState() => _WordsScreenState();
}

class _WordsScreenState extends State<WordsScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final NavigationServices nav = NavigationServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("A1 Greetings"),
      ),
      body: BlocProvider(
        create: (context) => WordBloc(
          authBloc: context.read<AuthBloc>(),
          databaseRepository: context.read<DatabaseRepository>(),
          localRepository: context.read<LocalRepository>(),
          level: widget.level,
          lesson: widget.lesson.label,
        ),
        child: BlocConsumer<WordBloc, WordState>(
          listener: (context, state) {
            if (state is WordComplete) {
              nav.pop(context);
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Image.asset(
                      PngImage.ribbon,
                      fit: BoxFit.contain,
                      height: 100,
                      width: 100,
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Congratulations you have completed beginner’s level! ",
                          textAlign: TextAlign.center,
                        ),
                        TextButton(
                          onPressed: () {
                            nav.pop(context);
                          },
                          child: const Text("Continue"),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
          builder: (context, state) {
            if (state is WordLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is WordLoaded) {
              return UserWords(
                state: state,
                lesson: widget.lesson,
              );
            } else {
              return Center(
                child: Text("$state"),
              );
            }
          },
        ),
      ),
    );
  }
}

class UserWords extends StatelessWidget {
  const UserWords({
    super.key,
    required this.state,
    required this.lesson,
  });

  final WordLoaded state;
  final LessonModel lesson;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final wordStream = state.userWords;
    final currentWords = state.userWords.where((element) => element.box == state.boxIndex).toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BoxCard(
              wordStream: wordStream,
              state: state,
            ),
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.arrow_back_outlined,
                      color: ColorTheme.tBlackColor,
                      size: 28.0,
                    ),
                    SizedBox(
                      width: 100,
                      child: Text(
                        "Swipe left to relearn",
                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        "Swipe right for next",
                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: ColorTheme.tBlackColor,
                      size: 28.0,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            state.duration != null
                ? FlashCard(wordModel: currentWords[0], state: state)
                : InkWell(
                    onTap: () {
                      context.read<WordBloc>().add(const UpdateFrontSide());
                    },
                    child: Draggable(
                      feedback: FlashCard(
                        wordModel: currentWords[0],
                        state: state,
                      ),
                      onDragUpdate: (details) {
                        context.read<WordBloc>().add(DragPosition(details: details));
                      },
                      onDragEnd: (details) {
                        if (details.offset.dx < -100) {
                          print("Swipe left");
                          // word.swipeCard(id: user.uid, word: currentWords[0]);
                          context.read<WordBloc>().add(SwipeCard(
                                wordList: currentWords,
                                currentWord: currentWords[0],
                                swipeRight: false,
                                level: currentWords[0].level,
                                lesson: lesson,
                              ));
                        } else if (details.offset.dx > 100) {
                          // word.swipeCard(id: user.uid, word: currentWords[0], swipeRight: true);
                          print("Swipe right");
                          context.read<WordBloc>().add(SwipeCard(
                                wordList: currentWords,
                                currentWord: currentWords[0],
                                swipeRight: true,
                                level: currentWords[0].level,
                                lesson: lesson,
                              ));
                        }
                      },
                      childWhenDragging: currentWords.length > 1
                          ? FlashCard(
                              state: state,
                              wordModel: currentWords[1],
                            )
                          : Container(),
                      child: FlashCard(
                        state: state,
                        wordModel: currentWords[0],
                      ),
                    ),
                  ),
            const SizedBox(height: 12.0),
          ],
        ),
      ),
    );
  }
}
