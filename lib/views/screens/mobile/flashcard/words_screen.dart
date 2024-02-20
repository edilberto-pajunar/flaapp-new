import 'package:flaapp/models/data.dart';
import 'package:flaapp/values/theme/colors.dart';
import 'package:flutter/material.dart';

class WordsScreen extends StatefulWidget {
  static String route = "/words";
  const WordsScreen({
    required this.dataModel,
    super.key,
  });

  final DataModel dataModel;

  @override
  State<WordsScreen> createState() => _WordsScreenState();
}

class _WordsScreenState extends State<WordsScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    // final wordProvider = Provider.of<WordProvider>(context);

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("A1 Greetings"),
        // leading: BackButton(
        //   onPressed: () {
        //     wordProvider.backButton(context);
        //   },
        // ),
      ),
      body:Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // SizedBox(
              //   height: size.height * 0.13,
              //   child: ListView.builder(
              //     itemCount: 5,
              //     shrinkWrap: true,
              //     scrollDirection: Axis.horizontal,
              //     itemBuilder: (context, index) {
              //       return Padding(
              //         padding: EdgeInsets.only(
              //           left: index == 0 ? 0 : 5.0,
              //         ),
              //         child: BoxCard(
              //           index: index,
              //           flashcard: data,
              //           onTap: () {
              //             if (data.timeEnded != null) {
              //               if (wordProvider.canUpdateBox(words: words, index: index)) {
              //                 wordProvider.updateBoxIndex(
              //                   index: index,
              //                 );
              //               }
              //             }
              //           },
              //         ),
              //       );
              //     },
              //   ),
              // ),
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
              // Stack(
              //   children: wordsFromSelectedBox.map((word) {
              //     return FlashCardWidget(
              //       word: word,
              //       flashCard: data,
              //       isFront: wordsFromSelectedBox.last == word,
              //       scaffoldKey: scaffoldKey,
              //     );
              //   }).toList(),
              // ),
              const SizedBox(height: 12.0),
            ],
          ),
        ),
      ),
    );
  }
}
