import 'package:flaapp/utils/constant/strings/image.dart';
import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  const NotFound({
    required this.label,
    super.key,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          PngImage.notFound,
        ),
        const SizedBox(height: 12.0),
        Center(
          child: Text(
            label,
          ),
        ),
      ],
    );
  }
}
