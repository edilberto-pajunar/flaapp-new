import 'package:flaapp/utils/constant/strings/image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WordSheet {
  static void completed(BuildContext context) {
    final theme = Theme.of(context);
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Image.asset(
            PngImage.ribbon,
            width: 100,
            height: 100,
          ),
          content: Text(
            "Congratulations, you have completed this lesson!",
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (context.mounted) context.pop();
                context.pop();
              },
              child: Text("Done"),
            ),
          ],
        );
      },
    );
  }
}
